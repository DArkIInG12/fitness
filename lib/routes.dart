import 'package:fitness/screens/dashboard_screen.dart';
import 'package:fitness/screens/excercices_screen.dart';
import 'package:fitness/screens/login_screen.dart';
import 'package:fitness/screens/register_screen.dart';
import 'package:flutter/widgets.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    '/login': (BuildContext context) => const LoginScreen(),
    '/register': (BuildContext context) => const RegisterScreen(),
    '/dashboard': (BuildContext context) => DashboardScreen(),
    '/excercices' : (BuildContext context) => const ExcercicesScreen(),
  };
}
 