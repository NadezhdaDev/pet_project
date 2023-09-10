import 'package:hive/hive.dart';

import '../../presentation/constants/pp_hive.dart';
part 'db_project_model.g.dart';

@HiveType(typeId: PPHive.hiveIdDbProjectModel)
class DBProjectModel extends HiveObject {
  @HiveField(0)
  String uuid;

  @HiveField(1)
  String? imagePath;

  DBProjectModel({
    required this.uuid,
    this.imagePath,
  });
}
