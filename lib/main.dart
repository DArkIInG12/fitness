import 'package:firebase_core/firebase_core.dart';
import 'package:fitness/provider.dart';
import 'package:fitness/routes.dart';
import 'package:fitness/screens/dashboard_screen.dart';
import 'package:fitness/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => ProviderModel(),
      child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProviderModel>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: getRoutes(),
      home: LoginScreen(),
      theme: provider.darkTheme == true ? ThemeData.dark() : ThemeData.light(),
    );
  }
}

//PROBAR OTRA CLASE DE PROVIDER PARA WIDGETS ESPECIFICOS
