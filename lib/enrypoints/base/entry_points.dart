import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import '../../data/repository/project_db_repository.dart';
import '../../domain/services/service_locator/prefs/prefs.dart';
import '../../internal/applicatiion/application.dart';
import '../../presentation/attributes/pp_app_config.dart';

class EntryPoints {
  static late PPAppConfig ppAppConfig;

  static Future<void> main(PPAppConfig appConfig) async {
    ppAppConfig = appConfig;
    WidgetsFlutterBinding.ensureInitialized();
    await registerSharedPrefs();
    await Hive.initFlutter().then((value) => ProjectDBRepository().init());
    return runApp(const Application());
  }
}