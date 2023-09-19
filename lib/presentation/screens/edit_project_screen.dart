import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pet_project/domain/services/translation/translation.dart';
import 'package:pet_project/presentation/widget/widget/buttons/rounded_scale_button.dart';
import 'dart:ui' as ui;
import '../attributes/pp_directory_path.dart';
import '../constants/pp_color.dart';
import '../state/project/project_cubit.dart';
import '../state/state_factory/screen_state_factory.dart';
import '../widget/widget/ui_image_painter.dart';

class EditProjectScreen extends StatefulWidget {
  final ProjectCubit projectCubit;

  const EditProjectScreen({super.key, required this.projectCubit});

  @override
  State<EditProjectScreen> createState() => _EditProjectScreenState();
}

class _EditProjectScreenState extends State<EditProjectScreen> {
  late final Size imageSize;

  static final snackBar = SnackBar(
    content: Text(Translator().notYetImpl),
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: PPColor.editorBackgroundColor,
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            FutureBuilder<ui.Image?>(
              future: _loadUiImage(widget.projectCubit.project.uuid),
              // a previously-obtained Future<String> or null
              builder:
                  (BuildContext context, AsyncSnapshot<ui.Image?> snapshot) {
                List<Widget> children;
                if (snapshot.hasData) {
                  children = <Widget>[
                    ClipRect(
                      child: CustomPaint(
                        painter: UIImagePainter(
                            image: snapshot.data!,
                            canvasSize: _getSize(context, imageSize),
                            imageSize: imageSize),
                        size: _getSize(context, imageSize),
                      ),
                    ),
                  ];
                } else if (snapshot.hasError) {
                  children = <Widget>[
                    const Icon(
                      Icons.error_outline,
                      color: PPColor.green,
                      size: 60,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text('Error: ${snapshot.error}'),
                    ),
                  ];
                } else {
                  children = const <Widget>[
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text('Awaiting result...'),
                    ),
                  ];
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: children,
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ScreenStateFactory(
                    stateFactory: () => RoundedScaleButton(onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: ScreenStateFactory(
                      stateFactory: () => RoundedScaleButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          buttonsIcon: const Icon(Icons.arrow_back)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<ui.Image?> _loadUiImage(String idProject) async {
    final directory = await getApplicationDocumentsDirectory();

    final photoProject = File(
        '${directory.path}/${PPDirectoryPath().folderEndpoint}/$idProject.png');

    Uint8List bytes = photoProject.readAsBytesSync();
    var decodedImage = await decodeImageFromList(bytes);
    imageSize =
        Size(decodedImage.width.toDouble(), decodedImage.height.toDouble());

    var byteDataImage = ByteData.view(bytes.buffer);

    final Completer<ui.Image> completer = Completer();
    ui.decodeImageFromList(Uint8List.view(byteDataImage.buffer),
        (ui.Image img) {
      return completer.complete(img);
    });

    return completer.future;
  }

  Size _getSize(BuildContext context, ui.Size imageSize) {
    final aspectRatio = imageSize.width / imageSize.height;
    double widthDeviseScreen = MediaQuery.of(context).size.width;
    double heightDeviceScreen = MediaQuery.of(context).size.height;
    if (aspectRatio > 1) {
      final imageWidth = widthDeviseScreen - 10;
      final imageHeight = imageWidth / aspectRatio;
      return Size(imageWidth, imageHeight);
    } else {
      final imageHeight = heightDeviceScreen - 100;
      final imageWidth = imageHeight * aspectRatio;
      return Size(imageWidth, imageHeight);
    }
  }
}
