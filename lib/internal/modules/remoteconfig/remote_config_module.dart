import 'package:pet_project/internal/modules/remoteconfig/pp_remote_config.dart';

class RemoteConfigModule {
  static PPRemoteConfig? _remoteConfig;

  static PPRemoteConfig get() {
    _remoteConfig ??= PPRemoteConfig();

    // ignore: avoid-non-null-assertion
    return _remoteConfig!;
  }
}