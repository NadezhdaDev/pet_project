import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../data/repository/project_db_repository.dart';
import '../../domain/model/project.dart';
import '../attributes/pp_directory_path.dart';
import '../navigation/navigation.dart';
import '../navigation/pp_route_path.dart';
import '../state/project/project_cubit.dart';
import '../state/state_factory/screen_state_factory.dart';
import '../widget/widget/buttons/gradient_scale_button.dart';
import '../widget/widget/lottie_widget/create_screen_lottie_widget.dart';

class CreateProjectScreen extends StatelessWidget {
  final ProjectCubit projectCubit;

  const CreateProjectScreen({super.key, required this.projectCubit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            width: MediaQuery.of(context).size.width - 30.0,
            child: const CreateScreenLottieWidget(),
          ),
          Center(
            child: ScreenStateFactory(
              stateFactory: () => GradientScaleButton(
                  label: 'Add photo',
                  onPressed: () async {
                    final idProject = const Uuid().v4();
                    final project = Project(uuid: idProject);
                    Future.wait([
                      ProjectDBRepository().add(project),
                      projectCubit.setProject(project),
                    ]).then((_) => addPhotoWithGallery(idProject).then(
                          (value) => navigate(
                            PPRoutePath.editProjectScreen,
                            argument: projectCubit,
                            replace: false,
                          ),
                        ));
                  }),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> addPhotoWithGallery(String idProject) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      Uint8List imageInBytes;

      imageInBytes = File(image.path).readAsBytesSync();

      final directory = await getApplicationDocumentsDirectory();
      if (!Directory('${directory.path}/${PPDirectoryPath().folderEndpoint}')
          .existsSync()) {
        Directory('${directory.path}/${PPDirectoryPath().folderEndpoint}')
            .create();
      }

      final photoProject = File(
          '${directory.path}/${PPDirectoryPath().folderEndpoint}/$idProject.png');

      photoProject.writeAsBytesSync(imageInBytes);
    }
  }
}
