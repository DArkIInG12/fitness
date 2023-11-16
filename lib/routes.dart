import 'package:fitness/screens/countdown_timer_screen.dart';
import 'package:fitness/screens/dashboard_screen.dart';
import 'package:fitness/screens/excercices_screen.dart';
import 'package:fitness/screens/login_screen.dart';
import 'package:fitness/screens/register_screen.dart';
import 'package:fitness/screens/settings_screen.dart';
import 'package:flutter/widgets.dart';

Map<String, WidgetBuilder> getRoutes() {
  return {
    '/login': (BuildContext context) => const LoginScreen(),
    '/register': (BuildContext context) => const RegisterScreen(),
    '/dashboard': (BuildContext context) => DashboardScreen(),
    '/settings': (BuildContext context) => SettingsScreen(),
    '/excercices': (BuildContext context) => const ExcercicesScreen(),
    '/coutdown': (BuildContext context) => const CountdownTimer(),
  };
}
