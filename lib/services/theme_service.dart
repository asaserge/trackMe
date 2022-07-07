import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices{
  final _box = GetStorage();
  final _keyDark = 'isDark';
  final _keyLang = 'lang';

  ThemeMode get theme => loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  bool loadThemeFromBox() => _box.read(_keyDark) ?? false;
  _saveThemeToBox(bool isDarkMode) => _box.write(_keyDark, isDarkMode);
  void switchTheme() {
    Get.changeThemeMode(loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeToBox(!loadThemeFromBox());
  }

  Locale loadLocale() => _box.read(_keyLang) ?? Locale(Get.deviceLocale!.languageCode, Get.deviceLocale!.countryCode);
  saveLocale(Locale locale) => _box.write(_keyLang, locale);


}