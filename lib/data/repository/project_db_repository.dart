import 'package:hive/hive.dart';

import '../../domain/model/project.dart';
import '../../domain/repository/project_repository.dart';
import '../mapper/project_maper.dart';
import '../model/db_project_model.dart';

class ProjectDBRepository implements ProjectRepository {
  static const _boxName = 'projects';
  static late Box<DBProjectModel> _box;
  final _projectMapper = ProjectMapper();

  @override
  Future<void> init() async {
    Hive.registerAdapter<DBProjectModel>(DBProjectModelAdapter());

    return Hive.openBox<DBProjectModel>(_boxName).then(
          (_) {
        _box = Hive.box<DBProjectModel>(_boxName);
      },
    );
  }

  @override
  List<Project> getProjects() {
    final projects = _box.values;

    final projectList = projects
        .map<Project>(
          (e) => _projectMapper.getProject(e),
    )
        .toList();
    return projectList;
  }

  @override
  Future<void> add(Project project) async {
    final model =  _projectMapper.getDBModel(project);
    await _box.add(model);
  }

  @override
  Future<void> update(Project project) {
    if (!_box.values.map((e) => e.uuid).toList().contains(project.uuid)) {
      return Future.value(null);
    }

    var dbModel = _box.values.firstWhere((element) => element.uuid == project.uuid);

    //update dbModel element
    //final newDBModel = projectMapper.getDBModel(project);
    //dbModel.element = newDBModel.element;

    return dbModel.save();
  }

  @override
  Future<void> remove(Project project) async {
    var dbModel = _box.values.firstWhere((element) => element.uuid == project.uuid);

    return dbModel.delete();
  }

}
