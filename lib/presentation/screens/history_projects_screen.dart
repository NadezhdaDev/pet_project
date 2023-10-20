import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pet_project/domain/repository/project_repository.dart';
import 'package:pet_project/presentation/navigation/navigation.dart';
import 'package:pet_project/presentation/state/project/project_cubit.dart';
import '../attributes/pp_directory_path.dart';
import '../navigation/pp_route_path.dart';

class HistoryProjectsScreen extends StatelessWidget {
  final ProjectCubit projectCubit;

  const HistoryProjectsScreen({super.key, required this.projectCubit});

  @override
  Widget build(BuildContext context) {
    var project = context.read<ProjectRepository>().getProjects();
    return ListView(
      children: project
          .map(
            (e) => Padding(
              padding: const EdgeInsetsDirectional.only(
                start: 16,
                end: 16,
                bottom: 34,
              ),
              child: FutureBuilder<File>(
                  future: _loadUiImage(e.uuid),
                  builder:
                      (BuildContext context, AsyncSnapshot<File> snapshot) {
                    if (snapshot.hasData) {
                      return GestureDetector(
                        child: Image.file(snapshot.data!),
                        onTap: () async => projectCubit.setProject(e).then(
                              (value) => navigate(
                                PPRoutePath.editProjectScreen,
                                argument: projectCubit,
                                replace: false,
                              ),
                            ),
                      );
                    }
                    return const SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
          )
          .toList(),
    );
  }

  Future<File> _loadUiImage(String projectId) async {
    final directory = await getApplicationDocumentsDirectory();

    final photoProject = File(
        '${directory.path}/${PPDirectoryPath().folderEndpoint}/$projectId.png');

    return photoProject;
  }
}
