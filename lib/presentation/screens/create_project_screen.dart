import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pet_project/presentation/state/locale/locale_cubit.dart';
import 'package:pet_project/presentation/state/locale/locale_state.dart';
import 'package:uuid/uuid.dart';

import '../../data/repository/project_db_repository.dart';
import '../../domain/model/project.dart';
import '../../domain/services/ads/google_ads.dart';
import '../../domain/services/translation/translation.dart';
import '../attributes/pp_directory_path.dart';
import '../constants/pp_color.dart';
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
      backgroundColor: PPColor.mainBackgroundColor,
      body:
          BlocBuilder<LocaleCubit, LocaleState>(builder: (contextCubit, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(width: 5.0, color: Colors.red),
                  ),
                  onPressed: () async {
                    final petProjectLibAdsPlugin = RewardedAds();
                    await petProjectLibAdsPlugin.loadAd(errorFunction: () {
                      if (kDebugMode) {
                        print(':(');
                      }
                    }, rewardedFunction: () {
                      if (kDebugMode) {
                        print(':)');
                      }
                    }, dismissFunction: () {
                      if (kDebugMode) {
                        print(':{');
                      }
                    });
                  },
                  child: const Text('Ads', style: TextStyle(color: Colors.red),),
                ),
                TextButton(
                  onPressed: () {
                    contextCubit.read<LocaleCubit>().setLocale(
                        context,
                        Translator.supportedLocales.firstWhere((element) =>
                        element != contextCubit.read<LocaleCubit>().locale));
                  },
                  child: Text(contextCubit.read<LocaleCubit>().locale.toString()),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width - 30.0,
              child: const CreateScreenLottieWidget(),
            ),
            Center(
              key: Key(contextCubit.read<LocaleCubit>().locale.toString()),
              child: ScreenStateFactory(
                stateFactory: () => GradientScaleButton(
                    label: Translator().addPhoto,
                    onPressed: () async {
                      var permissionRequest =
                          await Permission.storage.request();
                      final isCameraGranted = Platform.isAndroid
                          ? permissionRequest == PermissionStatus.granted
                          : permissionRequest !=
                              PermissionStatus.permanentlyDenied;
                      if (isCameraGranted) {
                        final idProject = const Uuid().v4();
                        final project = Project(uuid: idProject);
                        addPhotoWithGallery(idProject).then(
                          (value) => value
                              ? Future.wait([
                                  ProjectDBRepository().add(project),
                                  projectCubit.setProject(project),
                                ]).then(
                                  (value) => navigate(
                                    PPRoutePath.editProjectScreen,
                                    argument: projectCubit,
                                    replace: false,
                                  ),
                                )
                              : () {},
                        );
                      } else {
                        //ignore:use_build_context_synchronously
                        if (!context.mounted) return;
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: Text(Translator().permissionWarning),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                                child: Text(Translator().cansel),
                              ),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                  openAppSettings();
                                },
                                child: Text(Translator().setting),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
              ),
            ),
          ],
        );
      }),
    );
  }

  Future<bool> addPhotoWithGallery(String idProject) async {
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
      return true;
    }
    return false;
  }
}
