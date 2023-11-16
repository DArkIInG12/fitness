import 'package:flutter/material.dart';

class ProviderModel with ChangeNotifier {
  String _currentBody = 'TRAINING';
  int _indexOld = 0, _indexNew = 0;

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

  String _userName = '';
  String get userName => _userName;
  set userName(String value) {
    _userName = value;
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

  String _loginMessage = "";
  String get loginMessage => _loginMessage;
  set loginMessage(String value) {
    _loginMessage = value;
    notifyListeners();
  }

  String _registerMessage = "";
  String get registerMessage => _registerMessage;
  set registerMessage(String value) {
    _registerMessage = value;
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
  }

  int get indexOld => _indexOld;
  set indexOld(int value) {
    _indexOld = value;
    notifyListeners();
  }

  int get indexNew => _indexNew;
  set indexNew(int value) {
    _indexNew = value;
    notifyListeners();
  }
}
