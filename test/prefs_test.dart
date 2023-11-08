import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pet_project/data/prefs/pp_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'prefs_test.mocks.dart';

@GenerateMocks([SharedPreferences,PPPrefs])
void main() {
  group('PPPrefs', () {
    test('return local ru if prefs return ru', () async {
      final sharedPreferences = MockSharedPreferences();
      final ppPrefs = PPPrefs(sharedPreferences);
      
      when(sharedPreferences.getString('prefs_locale')).thenReturn('ru');

      expect(ppPrefs.getLocale(), const Locale('ru'));
    });

    test('return local en if prefs return en', () async {
      final sharedPreferences = MockSharedPreferences();
      final ppPrefs = PPPrefs(sharedPreferences);

      when(sharedPreferences.getString('prefs_locale')).thenReturn('en');

      expect(ppPrefs.getLocale(), const Locale('en'));
    });
  });
}