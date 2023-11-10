import 'package:flutter/material.dart';

class ProviderModel with ChangeNotifier {
  String _currentBody = 'TRAINING';
  String get currentBody => _currentBody;
  set currentBody(String value) {
    _currentBody = value;
    notifyListeners();
  }

  String _currentSettings = "";
  String get currentSettings => _currentSettings;
  set currentSettings(String value) {
    _currentSettings = value;
    notifyListeners();
  }

  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;
  set darkTheme(bool value) {
    _darkTheme = value;
    notifyListeners();
  }
}
