import 'package:firebase_core/firebase_core.dart';
import 'package:fitness/firebase/messaging.dart';
import 'package:fitness/global_values.dart';
import 'package:fitness/provider.dart';
import 'package:fitness/routes.dart';
import 'package:fitness/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await PushNotificationProvider().initNotifications();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('darkTheme')) {
    GlobalValues.darkTheme.value = prefs.getBool('darkTheme')!;
  } else {
    prefs.setBool('darkTheme', false);
    GlobalValues.darkTheme.value = prefs.getBool('darkTheme')!;
  }
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => ProviderModel(),
      child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: GlobalValues.darkTheme,
        builder: (context, value, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: getRoutes(),
            home: const LoginScreen(),
            theme: value == true ? ThemeData.dark() : ThemeData.light(),
          );
        });
  }
}
