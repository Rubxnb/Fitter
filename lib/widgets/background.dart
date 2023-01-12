import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fitter/theme/app_theme.dart';

class Background extends StatelessWidget {

  var boxDecoration = const BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          stops: [0.3, 0.9],
          colors: [
            Color.fromRGBO(0, 88, 161, 1),
            Color.fromRGBO(65, 208, 253, 1),

          ]
      )
  );

  @override
  Widget build(BuildContext context) {


    return Stack(
      children: [
        Container(
          decoration: boxDecoration,
        ),
        Center(
          child: Image.asset('assets/Fitter.png', alignment: Alignment.center,),
        )



      ],
    );
  }
}

class _PinkBox extends StatelessWidget {
  const _PinkBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi /18,
      child: Container(
        width: 10000,
        height: 36000,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(80),
            gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(65, 208, 253, 1),
                  Color.fromRGBO(0, 88, 161, 1),

                ]
            )
        ),
      ),
    );
  }
}
