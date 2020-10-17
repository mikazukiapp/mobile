import 'package:flutter/material.dart';

class AppTheme with ChangeNotifier {
  static bool _isDark = true;

  ThemeMode currentTheme() {
    return _isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Brightness currentBrightness() {
    return _isDark ? Brightness.dark : Brightness.light;
  }

  void switchTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }
}
