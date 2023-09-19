

import '../../domain/model/project.dart';
import '../model/db_project_model.dart';

class ProjectMapper {
  DBProjectModel getDBModel(Project project) {
    final DBProjectModel dbModel = DBProjectModel(
      uuid: project.uuid,
      imagePath: project.imagePath,
    );

    return dbModel;
  }

  Project getProject(DBProjectModel dbModel) {
    return Project(
      uuid: dbModel.uuid,
      imagePath: dbModel.imagePath,
    );
  }
}
