import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'dart:developer' as developer;

class PPRemoteConfig {
  final FirebaseRemoteConfig _instance;

  PPRemoteConfig()
      : _instance = FirebaseRemoteConfig.instance {
  _instance.setDefaults(_defaults);
  }

  static const _showTutorial = 'show_tutorial';

  Future<void> init() async {
    try {
      await _instance.ensureInitialized();
      await _instance.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );
      await _instance.fetchAndActivate();
    } on FirebaseException catch (e, st) {
      developer.log(
        'Unable to initialize Firebase Remote Config',
        error: e,
        stackTrace: st,
      );
    }
  }


  bool isShowTutorial() => _instance.getBool(_showTutorial);


  final _defaults = <String, dynamic> {
    _showTutorial: true,
  };
}
