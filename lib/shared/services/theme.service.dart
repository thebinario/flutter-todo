import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/config/factories/app.factory.dart';

import '../providers/storage.provider.dart';

class ThemeService {
  BuildContext context;

  final AppFactory appFactory = AppFactory.instance;

  ThemeService(this.context){
    getStorage();
  }


  setStorage() async {
    final value = json.encode(appFactory.notifier.value.toString());
    var sharedPreferencesProvider = Provider.of<SharedPreferencesProvider>(context, listen: false);
    await sharedPreferencesProvider.set('THEME_MODE', value);
  }

  getStorage() {
    var sharedPreferencesProvider = Provider.of<SharedPreferencesProvider>(context, listen: false);
    final value = sharedPreferencesProvider.get('THEME_MODE');

    if (value == null) return;

    final valueDecoded = json.decode(value);
    appFactory.notifier.value = _getTheme(valueDecoded);
  }

  _getTheme(valueDecoded){
    return valueDecoded == 'ThemeMode.dark' ? ThemeMode.dark : ThemeMode.light;
  }
}
