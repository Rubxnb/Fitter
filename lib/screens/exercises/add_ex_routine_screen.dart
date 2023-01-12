import 'package:fitter/models/models.dart';
import 'package:flutter/material.dart';

import '../../Exercises/Exercises.dart';
import '../../helpers/helpers.dart';
import '../../theme/app_theme.dart';

class AddExRoutineScreen extends StatefulWidget {
  const AddExRoutineScreen({Key? key}) : super(key: key);

  @override
  State<AddExRoutineScreen> createState() => _AddExRoutineScreenState();
}

class _AddExRoutineScreenState extends State<AddExRoutineScreen> {
  @override
  Widget build(BuildContext context) {
    String img = 'assets/Fitter.png';
    List<Ejercicio> ejercicios = Exercises.exercises;

    var selectedEx;
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir nuevo ejercicio'),
      ),
      body: Center(
        child: Column(
          children: [

            Text('Elegir ejercicio'),
            DropdownButton<Ejercicio>(
              value: selectedEx,
                items: ejercicios.map( (Ejercicio ejercicio) {
                  return DropdownMenuItem<Ejercicio>(
                    value: ejercicio,
                      child: Text(ejercicio.nombre));
                }).toList(),
                onChanged: (value) {

                }
            ),
            Image.asset(img),
          ],
        ),
      ),
    );
  }
}

List<DropdownMenuItem<Ejercicio>> _getItems() {
  List<DropdownMenuItem<Ejercicio>> res = [];
  List<Ejercicio> ej = Exercises.exercises;
  for(int i = 0; i < ej.length; i++) {
    res.add(DropdownMenuItem(
        child: Row(
          children: [
            Image.asset(getTipoIcon(ej[i].tipo), width: 30, height: 30,),
            Text(ej[i].nombre, style: AppTheme.textoNombreEj,)
          ],
        ),)
    );
  }

  return res;
}
