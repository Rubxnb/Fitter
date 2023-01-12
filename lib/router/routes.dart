import 'package:fitter/screens/home/qr_screen.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/screens.dart';
import '../widgets/widgets.dart';

class Routes {

  static const initialRoute = 'home';

  static final menuOptions = <MenuOption> [
    MenuOption(screen: const ExerciseScreen(), name: 'Ejercicios', route: 'exercise', image: 'assets/HomeScreenIcons/exerciseIconBlue.png'),
    MenuOption(screen: const RoutineScreen(), name: 'Rutinas', route: 'routine', image: 'assets/HomeScreenIcons/routineIconBlue.png'),
    MenuOption(screen: const GraphScreen(), name: 'Gráficos', route: 'graph', image: 'assets/HomeScreenIcons/graphIconBlue.png'),
    MenuOption(screen: ChronometerScreen(), name: 'Cronómetro', route: 'chronometer', image: 'assets/HomeScreenIcons/chronoIconBlue.png'),
    MenuOption(screen: CalendarScreen(), name: 'Calendario', route: 'calendar', image: 'assets/HomeScreenIcons/calendarIconBlue.png'),
    MenuOption(screen: const FavouritesScreen(), name: 'Favoritos', route: 'favourites', image: 'assets/HomeScreenIcons/favIconBlue.png'),
    MenuOption(screen: const QRScreen(), name: 'Escaner', route: 'qrscreen', image: 'assets/HomeScreenIcons/qrIconBlue.png'),
    MenuOption(screen: const IMC(), name: 'IMC', route: 'imc', image: 'assets/HomeScreenIcons/imcIcon.png'),
    MenuOption(screen: const ICC(), name: 'ICC', route: 'icc', image: 'assets/HomeScreenIcons/iccIcon.png'),
  ];

  static Map<String, Widget Function(BuildContext)> getRoutes () {

    Map<String, Widget Function(BuildContext)> appRoutes = {};

    appRoutes.addAll({'home' : (BuildContext context) => const HomeScreen()});
    for( final option in menuOptions) {
      appRoutes.addAll({option.route : (BuildContext context) => option.screen});
    }

    return appRoutes;
  }
}

