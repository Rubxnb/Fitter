import 'package:fitter/models/exercise_model.dart';
import 'package:fitter/models/menu_option.dart';
import 'package:flutter/material.dart';

import '../../router/routes.dart';
import '../../widgets/widgets.dart';


class ExerciseScreen extends StatelessWidget {
  const ExerciseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Ejercicios', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Stack(
          children: [
            Background(),
            _homeBody(size: size),
          ]
      ),
    );
  }
}
class _homeBody extends StatelessWidget {
  const _homeBody({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.11,),
            _CardTable(),
          ],
        )
    );
  }
}


class _CardTable extends StatelessWidget {
  const _CardTable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final menuOptions = Routes.menuOptions;

    return Table(
      children: [
        TableRow(
            children: [
              SingleCardExercises(tipo: Tipos.brazo, image: 'assets/ExerciseScreenIcons/armIconBlue.png', name: 'Brazos'),
              SingleCardExercises(tipo: Tipos.pecho, image: 'assets/ExerciseScreenIcons/chestIconBlue.png', name: 'Pecho'),
            ]
        ),
        TableRow(
            children: [
              SingleCardExercises(tipo: Tipos.abdominales, image: 'assets/ExerciseScreenIcons/absIconBlue.png', name: 'Abdominales'),
              SingleCardExercises(tipo: Tipos.espalda, image: 'assets/ExerciseScreenIcons/backIconBlue.png', name: 'Espalda'),
            ]
        ),
        TableRow(
            children: [
              SingleCardExercises(tipo: Tipos.gluteo, image: 'assets/ExerciseScreenIcons/botyIconBlue.png', name: 'Glúteos'),
              SingleCardExercises(tipo: Tipos.piernas, image: 'assets/ExerciseScreenIcons/legIconBlue.png', name: 'Piernas'),
            ]
        ),


      ],
    );
  }
}
