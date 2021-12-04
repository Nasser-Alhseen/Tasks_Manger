import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {

  
  final GetStorage box = GetStorage();

  final key = 'is Dark';
  bool loadTheme() {
    return box.read<bool>(key) ?? false;
  }

  saveTheme(bool isDark) {
    box.write(key, isDark);
  }

  void switchTheme() {
    Get.changeThemeMode(loadTheme() ? ThemeMode.light : ThemeMode.dark);
    saveTheme(!loadTheme());
  }

  ThemeMode get theme => loadTheme() ? ThemeMode.dark : ThemeMode.light;
}
