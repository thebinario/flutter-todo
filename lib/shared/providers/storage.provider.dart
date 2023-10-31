import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  late GetStorage prefs =  GetStorage();

  get(String key) {
    return prefs.read(key);
  }

  Future<void> set(String key, dynamic value) async {
    await prefs.write(key, value);
    notifyListeners(); // Notifica os ouvintes após a gravação no SharedPreferences
  }
}
