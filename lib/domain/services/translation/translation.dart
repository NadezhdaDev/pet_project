import 'dart:ui';

import 'app_translations.dart';

class Translator {
  static const supportedLocales = [
    Locale('en'),
    Locale('ru'),
  ];

  String get petProjectSpaced => 'PetProject';

  String get petProject => AppTranslations().getTranslateString('pet_project');
}