import 'dart:ui' as ui;
import 'dart:ui';

import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/services/translation/translation.dart';


class PPPrefs {

  PPPrefs([SharedPreferences? prefsExample]) : _prefs = prefsExample ?? GetIt.instance<SharedPreferences>();
  final SharedPreferences _prefs;

  final String _keyLocale = 'prefs_locale';
  final String _keyIsFirstLaunch = 'prefs_is_first_launch';

  Locale? getLocale() {
    if (_prefs.getString(_keyLocale) != null) {
      return Locale(_prefs.getString(_keyLocale)!);
    }

    if (Translator.supportedLocales.contains(Locale(ui.window.locale.languageCode))) {
      return Locale(ui.window.locale.languageCode);
    }

    return null;
  }

  Future<void> setLocale(Locale locale) async {
    await _prefs.setString(_keyLocale, locale.languageCode);
  }

  bool isFirstLaunch() => _prefs.getBool(_keyIsFirstLaunch)??true;

  Future<void> setFirstLaunch(bool isFirstLaunch) => _prefs.setBool(_keyIsFirstLaunch, isFirstLaunch);


}
