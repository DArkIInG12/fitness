import 'package:flutter/material.dart';

class ProviderModel with ChangeNotifier {
  String _currentBody = 'TRAINING';
  String get currentBody => _currentBody;
  set currentBody(String value) {
    _currentBody = value;
    notifyListeners();
  }

  String _userPhoto = '';
  String get userPhoto => _userPhoto;
  set userPhoto(String value) {
    _userPhoto = value;
    notifyListeners();
  }

  String _currentSettings = "";
  String get currentSettings => _currentSettings;
  set currentSettings(String value) {
    _currentSettings = value;
    notifyListeners();
  }

  String _selectedItem = "";
  String get selectedItem {
    return _selectedItem;
  }

  set selectedItem(String value) {
    _selectedItem = value;
    notifyListeners();
  }

  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;
  set darkTheme(bool value) {
    _darkTheme = value;
    notifyListeners();
  }

  bool _emailConfirmedPwd = false;
  bool get emailConfirmedPwd => _emailConfirmedPwd;
  set emailConfirmedPwd(bool value) {
    _emailConfirmedPwd = value;
    notifyListeners();
  }

  bool _changeState = false;
  bool get changeState => _changeState;
  set changeState(bool value) {
    _changeState = value;
    notifyListeners();
  }
}
