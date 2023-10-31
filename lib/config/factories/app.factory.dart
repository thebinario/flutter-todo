import 'package:flutter/material.dart';
import 'package:todo/shared/services/theme.service.dart';

class AppFactory {
  bool _initInstance = false;

  static AppFactory _instance = AppFactory._internal();

  static get instance {
    if (_instance._initInstance == false) {
      _instance = AppFactory._internal();
      _instance._initInstance = true;
    }

    return _instance;
  }

  AppFactory._internal();

  bool isDark = true;
  ThemeMode themeMode = ThemeMode.system;
  ValueNotifier<ThemeMode> notifier = ValueNotifier(ThemeMode.light);

  onThemeMode(mode) {
    themeMode = mode;
    return mode;
  }
}
