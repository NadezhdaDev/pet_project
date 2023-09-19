import 'dart:ui';

import 'app_translations.dart';

class Translator {
  static const supportedLocales = [
    Locale('en'),
    Locale('ru'),
  ];

  String get petProjectSpaced => 'PetProject';

  String get petProject => AppTranslations().getTranslateString('pet_project');

  String get permissionWarning => AppTranslations().getTranslateString('permission_warning');
  String get cansel=> AppTranslations().getTranslateString('cansel');
  String get setting=> AppTranslations().getTranslateString('setting');
  String get addPhoto=> AppTranslations().getTranslateString('add_photo');
  String get notYetImpl=> AppTranslations().getTranslateString('not_yet_impl');
  String get newProject=> AppTranslations().getTranslateString('new_project');
  String get allProjects=> AppTranslations().getTranslateString('all_projects');

}