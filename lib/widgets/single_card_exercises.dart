import 'dart:ui';

import 'package:fitter/screens/exercises/exercises_screen.dart';
import 'package:fitter/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class SingleCardExercises extends StatelessWidget {

  final Tipos tipo;
  final String image;
  final String name;
  const SingleCardExercises({Key? key, required this.tipo, required this.image, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute (builder: (BuildContext context) => ExercisesScreen(tipo: tipo, nombreEj: name,)));
      },
      child: Container(
        margin: EdgeInsets.all(25),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color.fromRGBO(255, 255, 255, 1),

              ),

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(image, height: 50, width: 50,),
                  SizedBox(height: 10,),
                  Text(name, style: AppTheme.textoBotonesMenus,)
                ],
              ),

            ),
          ),
        ),
      ),
    );
  }
}
