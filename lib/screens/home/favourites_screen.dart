import 'package:fitter/models/exercise_model.dart';
import 'package:flutter/material.dart';

import '../../router/routes.dart';
import '../../widgets/widgets.dart';


class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Favoritos', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
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

    return Table(
      children: [
        TableRow(
            children: [
              SingleCardFavExercises(tipo: Tipos.brazo, image: 'assets/FavIcons/armFavIconBlue.png', name: 'Brazos'),
              SingleCardFavExercises(tipo: Tipos.pecho, image: 'assets/FavIcons/chestFavIconBlue.png', name: 'Pecho'),
            ]
        ),
        TableRow(
            children: [
              SingleCardFavExercises(tipo: Tipos.abdominales, image: 'assets/FavIcons/absFavIconBlue.png', name: 'Abdominales'),
              SingleCardFavExercises(tipo: Tipos.espalda, image: 'assets/FavIcons/backFavIconBlue.png', name: 'Espalda'),
            ]
        ),
        TableRow(
            children: [
              SingleCardFavExercises(tipo: Tipos.gluteo, image: 'assets/FavIcons/botyFavIconBlue.png', name: 'Glúteos'),
              SingleCardFavExercises(tipo: Tipos.piernas, image: 'assets/FavIcons/legFavIconBlue.png', name: 'Piernas'),
            ]
        ),
      ],
    );
  }
}
