import 'package:fitter/Exercises/Exercises.dart';
import 'package:fitter/theme/app_theme.dart';
import 'package:flutter/material.dart';

import '../../models/models.dart';
import '../../widgets/widgets.dart';

class FavExercisesScreen extends StatelessWidget {
  final Tipos tipo;
  final String nombreEj;
  const FavExercisesScreen({Key? key, required this.tipo, required this.nombreEj}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<EjercicioRecomendado> ejercicios = Exercises.getFavExercisesRecomendedType(tipo);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(nombreEj, style: AppTheme.textoTitulo,),
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
          children: [
            Background(),
            ListView.builder(
              itemCount: ejercicios.length,
              itemBuilder: (context, index) =>
                  ListTile(

                    title: ListCardExercises(ej: ejercicios[index]),

                  ),
            ),
          ]
      ),
    );
  }
}