import 'dart:async';
import 'package:flutter/foundation.dart';

class CountdownModel extends ChangeNotifier {
  late Timer _timerdown;
  late Timer _timerup;
  int seconds;
  int items;
  int _currentImageIndex = 0;
  int _secondsRemaining = 1;
  int _secondsIncrease = 0;
  bool _isPaused = false;
  bool _isDiferent2Zero = true;

  int get secondsRemaining => _secondsRemaining;

  bool get isPaused => _isPaused;
  set isPaused(bool value) {
    _isPaused = value;
  }

  bool get isDiferent2Zero => _isDiferent2Zero;
  int get currentImageIndex => _currentImageIndex;
  int get secondsIncrease => _secondsIncrease;

  CountdownModel({required this.seconds, required this.items}) {
    _secondsRemaining = seconds;
    startCountdown();
  }

  void startCountUp() {
    _timerup = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        _secondsIncrease++;
        notifyListeners();
      }
    });
  }

  void startCountdown() {
    _timerdown = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
          notifyListeners();
        } else {
          _isDiferent2Zero = false;
          notifyListeners();
          _timerdown.cancel();
          startCountUp();
        }
      }
    });
  }

  void updateIndexImage() {
    _currentImageIndex = (_currentImageIndex + 1) % items;
    notifyListeners();
  }

  void togglePause() {
    _isPaused = !_isPaused;
    notifyListeners();
  }

  @override
  void dispose() {
    _timerdown.cancel();
    _timerup.cancel();
    super.dispose();
  }
}
