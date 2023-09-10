

import 'dart:io';

import '../presentation/attributes/enum/store_type.dart';
import '../presentation/attributes/pp_app_config.dart';
import 'base/entry_points.dart';

void main() async {
  final storeType = Platform.isAndroid ? StoreType.googlePlay : StoreType.appStore;

  final appConfig = PPAppConfig(
    storeType,
  );

  return EntryPoints.main(
    appConfig,
  );
}