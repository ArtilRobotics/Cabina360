import 'package:cabina360_app/widgets/background.dart';
import 'package:flutter/material.dart';

class CamaraScreen extends StatelessWidget {
  const CamaraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Background
          const Background(),
          //Homebody
          //_HomeBody(),
          //Boton Camara
          //const GaleriaScreen(),
          //_botonCamara(),
          _botonCamara(context)
        ],
      ),
    );
  }
}

Container _botonCamara(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    child: ElevatedButton(
      onPressed: () {
        //Navigator.pushNamed(context, 'camaraapi');
        Navigator.pushNamed(context, 'camaraapi');
      },
      style: ElevatedButton.styleFrom(
        shape: const CircleBorder(),
        padding: const EdgeInsets.all(20),
        backgroundColor: const Color.fromRGBO(55, 57, 84, 1),
      ),
      child: const Icon(
        Icons.camera_alt_outlined,
        color: Colors.white,
        size: 54,
      ),
    ),
  );
}
