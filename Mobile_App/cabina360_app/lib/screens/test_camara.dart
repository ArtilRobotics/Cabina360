import 'package:cabina360_app/screens/create_vid.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

List<CameraDescription> cameras = <CameraDescription>[];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CreateVid(),
    );
  }
}
