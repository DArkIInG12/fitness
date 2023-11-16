import 'dart:async';
import 'package:flutter/foundation.dart';

class CountdownModel extends ChangeNotifier {
  late Timer _timer;
  int seconds;
  int _secondsRemaining = 0;
  bool _isPaused = false;

  int get secondsRemaining => _secondsRemaining;
  bool get isPaused => _isPaused;

  CountdownModel({required this.seconds}) {
    _secondsRemaining = seconds;
    startCountdown();
  }

  void startCountdown() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
          notifyListeners();
        } else {
          _timer.cancel();
        }
      }
    });
  }

  void togglePause() {
    _isPaused = !_isPaused;
    notifyListeners();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
