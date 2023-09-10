import '../model/project.dart';

abstract class ProjectRepository {
  Future<void> init();

  List<Project> getProjects();

  Future<void> add(Project project);

  Future<void> update(Project project);

  Future<void> remove(Project project);
}
