import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pet_project/presentation/navigation/navigation.dart';
import 'package:pet_project/presentation/state/project/project_cubit.dart';
import '../../data/repository/project_db_repository.dart';
import '../attributes/pp_directory_path.dart';
import '../navigation/pp_route_path.dart';

class HistoryProjectsScreen extends StatelessWidget {
  final ProjectCubit projectCubit;

  const HistoryProjectsScreen({super.key, required this.projectCubit});

  @override
  Widget build(BuildContext context) {
    var project = ProjectDBRepository().getProjects();
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
                        onTap: () =>
                          navigate(
                            PPRoutePath.editProjectScreen,
                            argument: projectCubit,
                            replace: false,
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
