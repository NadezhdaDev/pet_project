import 'dart:ui' as ui;
import 'dart:ui';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/services/translation/translation.dart';


class PPPrefs {
  SharedPreferences prefs = GetIt.instance<SharedPreferences>();

  final String _keyLocale = 'prefs_locale';
  final String _keyIsFirstLaunch = 'prefs_is_first_launch';

  Locale? getLocale() {
    if (prefs.getString(_keyLocale) != null) {
      return Locale(prefs.getString(_keyLocale)!);
    }

    if (Translator.supportedLocales.contains(Locale(ui.window.locale.languageCode))) {
      return Locale(ui.window.locale.languageCode);
    }

    return null;
  }

  Future<void> setLocale(Locale locale) async {
    await prefs.setString(_keyLocale, locale.languageCode);
  }

  bool isFirstLaunch() => prefs.getBool(_keyIsFirstLaunch)??true;

  Future<void> setFirstLaunch(bool isFirstLaunch) => prefs.setBool(_keyIsFirstLaunch, isFirstLaunch);


}
