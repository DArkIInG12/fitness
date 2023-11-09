import 'package:flutter/material.dart';

class ProviderModel with ChangeNotifier {
  String _currentBody = 'TRAINING';
  String get currentBody => _currentBody;
  set currentBody(String value) {
    _currentBody = value;
    notifyListeners();
  }
}
