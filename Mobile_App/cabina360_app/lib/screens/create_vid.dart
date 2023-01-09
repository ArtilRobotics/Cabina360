import 'package:cabina360_app/screens/test_camara.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CreateVid extends StatefulWidget {
  const CreateVid({super.key});

  @override
  State<CreateVid> createState() => _CreateVidState();
}

//String path;

class _CreateVidState extends State<CreateVid> {
  late CameraController controller;
  late Future<void> initializeControllerFuture;
  bool isDisabled = false;

  @override
  void initState() {
    super.initState();

    controller = CameraController(cameras[0], ResolutionPreset.high);
    initializeControllerFuture = controller.initialize();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: CameraPreview(controller),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: !controller.value.isRecordingVideo
                      ? RawMaterialButton(
                          onPressed: () async {
                            try {
                              await initializeControllerFuture;
                              var path = join(
                                  (await getApplicationDocumentsDirectory())
                                      .path,
                                  '${DateTime.now()}.mp4');

                              setState(() {
                                controller.startVideoRecording();
                                isDisabled = true;
                                isDisabled = !isDisabled;
                              });
                            } catch (e) {
                              print(e);
                            }
                          },
                          padding: const EdgeInsets.all(10.0),
                          shape: const CircleBorder(),
                          child: const Icon(
                            Icons.camera,
                            size: 50.0,
                            color: Colors.yellow,
                          ),
                        )
                      : null,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: isDisabled == !controller.value.isRecordingVideo
                      ? RawMaterialButton(
                          onPressed: () {
                            setState(() {
                              if (controller.value.isRecordingVideo) {
                                controller.stopVideoRecording();
                                isDisabled = false;
                                isDisabled = !isDisabled;
                              }
                            });
                          },
                          padding: EdgeInsets.all(10.0),
                          shape: const CircleBorder(),
                          child: const Icon(
                            Icons.stop,
                            size: 50.0,
                            color: Colors.red,
                          ),
                        )
                      : null,
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
