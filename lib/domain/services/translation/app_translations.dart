import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentation/state/locale/locale_cubit.dart';

class AppTranslations {

  static late Map _decoded;

  Future<String> _loadJsonLocaleAsset(BuildContext context) async {
    var localeCubit = context.read<LocaleCubit>;
    return await rootBundle.loadString(localePath(localeCubit.call().locale.languageCode));
  }

  Future<void> loadJsonLocale(BuildContext context) async {
    String jsonCrossword = await _loadJsonLocaleAsset(context);
    _decoded = jsonDecode(jsonCrossword);
  }

  String localePath(String locale) => 'assets/locale/$locale.json';

  String getTranslateString(String key){
    return _decoded[key];
  }

}