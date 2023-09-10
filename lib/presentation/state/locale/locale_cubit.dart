import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/services/translation/app_translations.dart';
import 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  Locale _locale;

  Locale get locale => _locale;

  LocaleCubit(this._locale) : super(LocaleState(locale: _locale)) {
    emit(LocaleState(locale: _locale));
  }

  Future<void> setLocale(BuildContext context, Locale value) async {
    _locale = value;
    await AppTranslations().loadJsonLocale(context);
    emit(LocaleState(locale: _locale));
  }
}