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
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProviderModel(),
      child: MaterialApp(
        routes: getRoutes(),
        home: LoginScreen(),
      ),
    );
  }
}
