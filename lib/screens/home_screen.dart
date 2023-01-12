import 'package:fitter/theme/app_theme.dart';
import 'package:flutter/material.dart';

import 'package:fitter/widgets/widgets.dart';

import '../router/routes.dart';
import '../widgets/single_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Fitter', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: Stack(
        children: [
          Background(),

        homeBody(size: size)

        ]
      ),
    );
  }
}


class homeBody extends StatelessWidget {
  const homeBody({
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

          SingleCard(menuOption: Routes.menuOptions[6], width: 155,),
        ],
      )
    );
  }
}

class Title extends StatelessWidget {
  const Title({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        color: Colors.white,
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('assets/Fitter.png'), width: 60, height: 60,),
            SizedBox(width: 10,),
            Text('FITTER', style: TextStyle(fontSize: 30, color: AppTheme.blue, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
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
              SingleCard(menuOption: menuOptions[0],),
              SingleCard(menuOption: menuOptions[1]),
            ]
        ),
        TableRow(
            children: [
              SingleCard(menuOption: menuOptions[2]),
              SingleCard(menuOption: menuOptions[3]),
            ]
        ),
        TableRow(
            children: [
              SingleCard(menuOption: menuOptions[4]),
              SingleCard(menuOption: menuOptions[5]),
            ]
        ),
      ],
    );
  }
}
