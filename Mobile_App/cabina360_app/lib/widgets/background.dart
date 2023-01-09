import 'dart:math';

import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  const Background({super.key});
  final boxDecoration = const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.2, 0.8],
          colors: [Color(0xffB5C6E4), Color(0xffE3ACCB)]));

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        //Purple Gradient
        Container(decoration: boxDecoration),

        //pink box
        //Positioned(top: -100, left: -30, child: _PinkBox()),
      ],
    );
  }
}

class _PinkBox extends StatelessWidget {
  //const _PinkBox({super.key});
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 5.0,
      child: Container(
        width: 360,
        height: 360,
        decoration: BoxDecoration(
            color: Colors.pink,
            borderRadius: BorderRadius.circular(80),
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(236, 98, 188, 1),
              Color.fromRGBO(241, 142, 172, 1)
            ])),
      ),
    );
  }
}
