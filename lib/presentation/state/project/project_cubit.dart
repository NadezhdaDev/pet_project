

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_project/presentation/state/project/project_state.dart';

import '../../../domain/model/project.dart';

class ProjectCubit extends Cubit<ProjectState> {
  Project _project;

  Project get project => _project;

  ProjectCubit(this._project) : super(ProjectState(project: _project)) {
    emit(ProjectState(project: _project));
  }

  Future<void> setProject(Project value) async {
    _project = value;
    emit(ProjectState(project: _project));
  }

}