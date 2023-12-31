import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/adapters.dart';

import '../../data/repository/project_db_repository.dart';
import '../../domain/repository/project_repository.dart';
import '../../domain/services/service_locator/prefs/prefs.dart';
import '../../firebase_options.dart';
import '../../internal/applicatiion/application.dart';
import '../../internal/modules/remoteconfig/pp_remote_config.dart';
import '../../presentation/attributes/pp_app_config.dart';


class EntryPoints {
  static late PPAppConfig ppAppConfig;

  static Future<void> main(PPAppConfig appConfig) async {
    ppAppConfig = appConfig;
    WidgetsFlutterBinding.ensureInitialized();
    await registerSharedPrefs();
    await MobileAds.instance.initialize();
    final repository = ProjectDBRepository();
    await Hive.initFlutter().then((value) => repository.init());
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    ).then((value) => PPRemoteConfig().init().then((value) {
      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };
      // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    }));

    return runApp(RepositoryProvider<ProjectRepository>.value(
      value: repository,
      child: const Application(),
    ),);
  }
}
