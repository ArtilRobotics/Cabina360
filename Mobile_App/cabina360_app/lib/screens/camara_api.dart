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
  bool inicio_grabacion = false;
  bool _visibilidad = false;

  static const maxSeconds = 3;
  int seconds = maxSeconds;
  Timer? timer;

  void startTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        setState(() => seconds--);
      } else {
        stopTimer(reset: false);
      }
      if (seconds == 0) {
        //stopTimer();
        inicio_grabacion = true;
        _visibilidad = false;
      }
    });
  }

  void stopTimer({bool reset = true}) {
    if (reset) {
      resetTimer();
    }
    setState(() => timer?.cancel());
    //timer?.cancel();
  }

  void resetTimer() => setState(() => seconds = maxSeconds);

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
    //final isRunning = timer == null ? false : timer!.isActive;
    //final isCompleted = seconds == maxSeconds || seconds == 0;

    return Stack(
      children: [
        Align(
          alignment: Alignment.center,
          child: body,
        ),
        //body,
        Visibility(
          visible: _visibilidad,
          child: Align(
            alignment: Alignment.center,
            child: Text(
              '$seconds',
              style: const TextStyle(
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 80,
              ),
            ),
          ),
        ),
        Visibility(
          visible: _visibilidad,
          child: Align(
              child: SizedBox(
            width: 200,
            height: 200,
            child: CircularProgressIndicator(
              value: 1 - seconds / maxSeconds,
              valueColor: const AlwaysStoppedAnimation(Colors.white),
              strokeWidth: 12,
              backgroundColor: Colors.greenAccent,
            ),
          )),
        ),

        // Positioned(
        //   top: 0.0,
        //   left: 0.0,
        //   right: 0.0,
        //   child: AppBar(
        //     title: const Text('Camara'),
        //     backgroundColor: Colors.green,
        //   ),
        // ),
        Align(
            alignment: const Alignment(0, 0.9), //x,y
            heightFactor: double.infinity,
            child: ElevatedButton(
              onPressed: seconds == maxSeconds
                  ? () async {
                      _visibilidad = true;
                      inicioTimerGrabacion();
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                  shape: const CircleBorder(),
                  padding: const EdgeInsets.all(20),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.pink[20],
                  disabledBackgroundColor: Colors.grey,
                  disabledForegroundColor: Colors.grey),
              child: const Icon(
                Icons.circle,
                color: Colors.red,
                size: 45,
              ),
            )),
      ],
    );
  }

  void inicioTimerGrabacion() async {
    startTimer();
    Timer(const Duration(seconds: 3), startRecording);
  }

  void imprimir() {
    print('Inicio Grabacion');
  }

  Future initializeCamera() async {
    _widgetState = WidgetState.lOADING;
    if (mounted) setState(() {});

    _cameras =
        await availableCameras(); //no pasa a la siguiente linea hasta que se ejecute

    _cameraController = CameraController(
        _cameras[0], ResolutionPreset.ultraHigh,
        enableAudio: true);

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
  }

  void stopVideoRecording() async {
    final file = await _cameraController.stopVideoRecording();
    await GallerySaver.saveVideo(file.path);
    File(file.path).deleteSync();
    print('Fin de la Grabacion');
    resetTimer();
    //print(file.path);
    //String path = join((await getApplicationDocumentsDirectory()).path,
    //    '${DateTime.now()}.mp4');
    //await file.saveTo(path);
  }
}
