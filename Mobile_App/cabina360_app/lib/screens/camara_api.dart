import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:gallery_saver/gallery_saver.dart';

class CamaraAPIScreen extends StatefulWidget {
  const CamaraAPIScreen({super.key});

  @override
  State<CamaraAPIScreen> createState() => _CamaraAPIScreenState();
}

enum WidgetState { nONE, lOADING, lOADED, eRROR }

class _CamaraAPIScreenState extends State<CamaraAPIScreen> {
  WidgetState _widgetState = WidgetState.nONE;
  List<CameraDescription> _cameras = <CameraDescription>[];
  late CameraController _cameraController;
  bool isButtonActive = true;
  int _counter = 10;
  late Timer _timer;

  void _startTimer() {
    _counter = 10;
    if (_timer != null) {
      _timer.cancel();
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  @override
  Widget build(BuildContext context) {
    switch (_widgetState) {
      case WidgetState.nONE:
      case WidgetState.lOADING:
        return _buildScaffold(
            context,
            const Center(
              child: CircularProgressIndicator(),
            ));
      case WidgetState.lOADED:
        return _buildScaffold(context, CameraPreview(_cameraController));
      case WidgetState.eRROR:
        return _buildScaffold(
            context,
            const Center(
              child: Text(
                  'La camara no se pudo inicializar. Reinicia la aplicacion.'),
            ));
    }
  }

  Widget _buildScaffold(BuildContext context, Widget body) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camara Flutter"),
        centerTitle: true,
        backgroundColor: Colors.amber,
        elevation: 0,
      ),
      body: body,
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            //XFile xfile = await _cameraController.takePicture();
            //obtener la ruta de la imagen donde se guardo la foto y retornar a la escena anterior
            // ignore: use_build_context_synchronously
            //Navigator.pop(context, xfile.path);

            widgetContador();
            _startTimer();

            //Timer(const Duration(seconds: 3), startRecording);
            print("Inicio grabacion");
          },
          child: const Icon(Icons.camera)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Scaffold widgetContador() {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            (_counter > 0)
                ? const Text("")
                : const Text(
                    "DONE!",
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 48),
                  ),
            Text(
              '$_counter',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 48,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future initializeCamera() async {
    _widgetState = WidgetState.lOADING;
    if (mounted) setState(() {});

    _cameras =
        await availableCameras(); //no pasa a la siguiente linea hasta que se ejecute

    _cameraController =
        CameraController(_cameras[0], ResolutionPreset.high, enableAudio: true);

    await _cameraController.initialize();

    if (_cameraController.value.hasError) {
      _widgetState = WidgetState.eRROR;
      if (mounted) setState(() {});
    } else {
      _widgetState = WidgetState.lOADED;
      if (mounted) setState(() {});
    }
  }

  void startRecording() async {
    await _cameraController.prepareForVideoRecording();
    await _cameraController.startVideoRecording();

    Timer(const Duration(seconds: 10), stopVideoRecording);
    print("Fin de la grabacion");
    setState(
      () => isButtonActive = true,
    );
  }

  void stopVideoRecording() async {
    final file = await _cameraController.stopVideoRecording();
    print(file.path);
    await GallerySaver.saveVideo(file.path);
    File(file.path).deleteSync();
    //print(file.path);
    //String path = join((await getApplicationDocumentsDirectory()).path,
    //    '${DateTime.now()}.mp4');
    //await file.saveTo(path);
  }
}
