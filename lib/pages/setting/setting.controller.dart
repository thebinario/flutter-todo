import 'package:flutter/material.dart';
import 'package:todo/config/factories/app.factory.dart';
import 'package:todo/shared/services/theme.service.dart';
import 'package:todo/shared/services/theme.service.dart';

class SettingController extends ChangeNotifier {
  final AppFactory  appFactory = AppFactory.instance;

  late BuildContext context;

  SettingController(this.context);

  onChangeTheme() {
    final ThemeService themeService = ThemeService(context);
    appFactory.notifier.value = isLight ? ThemeMode.light : ThemeMode.dark;
    themeService.setStorage();
    notifyListeners();
  }

  get isLight {
    return appFactory.themeMode.toString() == 'ThemeMode.dark';
  }
}
