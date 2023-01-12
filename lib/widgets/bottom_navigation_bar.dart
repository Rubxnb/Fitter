import 'package:fitter/models/my_flutter_app_icons.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {

    int _selectedIndex = 2;

    void onItemTapped(int index) {
      setState(( ) {
        _selectedIndex = index;
      });
    }

    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      selectedItemColor: AppTheme.blue,
      backgroundColor: AppTheme.darkBlue,
      unselectedItemColor: Colors.white,
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,
      onTap: onItemTapped,
      items: const [
        BottomNavigationBarItem(icon: Icon(MyFlutterApp.calendaricondarkblue), label: 'Calendario'),
        BottomNavigationBarItem(icon: Icon(MyFlutterApp.graphicondarkblue), label: 'Gráficas'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(MyFlutterApp.routineicondarkblue) , label: 'Rutinas'),
        BottomNavigationBarItem(icon: Icon(MyFlutterApp.exercisesicondarkblue), label: 'Ejercicios'),
      ],

    );
  }
}
