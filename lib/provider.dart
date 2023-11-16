import 'package:flutter/material.dart';

class ProviderModel with ChangeNotifier {
  String _currentBody = 'TRAINING';
  int _indexOld = 0, _indexNew = 0;


  String get currentBody => _currentBody;
  set currentBody(String value) {
    _currentBody = value;
    notifyListeners();
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
