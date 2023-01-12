import 'package:fitter/Exercises/Exercises.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../helpers/helpers.dart';
import '../models/models.dart';
import '../theme/app_theme.dart';

class AddExerciseRoutine extends StatefulWidget {
  final String day;
  final List<Routine> routines;
  final ValueChanged<Routine> parentAction;

  const AddExerciseRoutine({Key? key, required this.day, required this.routines, required this.parentAction}) : super(key: key);

  @override
  State<AddExerciseRoutine> createState() => _AddExerciseRoutineState();
}

class _AddExerciseRoutineState extends State<AddExerciseRoutine> {
  String dropDownTiposValue = '';
  String dropDownExerciseValue = '';

  List<Ejercicio> ejercicios = [];

  String image = 'assets/Fitter.png';

  bool rep_time = true;

  String v1 = '';
  String v2 = '';
  String tipoRepTiempo = 'x';

  String validatorMessage = '';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Nuevo ejercicio - ${daysTradcutor(widget.day)}'),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.symmetric(vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Seleccione un grupo muscular', style: TextStyle(fontSize: 18),),
              DropdownButton(
                style: const TextStyle(color: AppTheme.blue, fontSize: 18, fontWeight: FontWeight.bold),
                icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppTheme.blue,),
                underline: Container(
                  height: 2,
                  color: AppTheme.blue,
                ),
                  value: dropDownTiposValue,
                  items: getItemMuscles(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropDownTiposValue = newValue!;
                      ejercicios = getEjerciciosByType(newValue);
                    });
                  },
              ),
              SizedBox(height: 10,),
              Text('Seleccione un ejercicio', style: TextStyle(fontSize: 18),),
              DropdownButton(
                style: const TextStyle(color: AppTheme.blue, fontSize: 18, fontWeight: FontWeight.bold),
                icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppTheme.blue,),
                underline: Container(
                  height: 2,
                  color: AppTheme.blue,
                ),
                value: dropDownExerciseValue,
                items: getItemExercises(dropDownTiposValue),
                onChanged: (String? newValue) {
                  setState(() {
                    dropDownExerciseValue = newValue!;
                    image = getImage(dropDownExerciseValue, ejercicios);
                  });
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Rep/Serie', style: AppTheme.textoRecomendadoEj),
                  Radio(
                    groupValue: rep_time,
                    value: true,
                    onChanged: (bool? value) {
                      setState(() {
                        rep_time =  value!;
                        tipoRepTiempo = getRepTiempo(rep_time);

                      });
                    },
                  ),
                  Text('Tiempo', style: AppTheme.textoRecomendadoEj),
                  Radio(
                    groupValue: rep_time,
                    value: false,
                    onChanged: (bool? value) {
                      setState(() {
                        rep_time =  value!;
                        tipoRepTiempo = getRepTiempo(rep_time);
                      });
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 Container(
                   width: 30,
                   height: 45,
                   child: TextFormField(
                     maxLength: 2,
                     style: TextStyle(fontSize: 20, color: AppTheme.blue, fontWeight: FontWeight.bold),
                     keyboardType: TextInputType.number,
                     decoration: InputDecoration(
                       counterText: ''
                     ),
                     onChanged: (value) {
                       v1 = value;
                     },
                   ),
                 ),
                  Text(tipoRepTiempo, style: TextStyle( fontSize: 18),),
                  SizedBox(width: 5,),
                  Container(
                    width: 30,
                    height: 45,
                    child: TextFormField(
                      maxLength: 2,
                      style: TextStyle(fontSize: 20, color: AppTheme.blue, fontWeight: FontWeight.bold),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          counterText: ''
                      ),
                      onChanged: (value) {
                        v2 = value;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              Image(image: AssetImage(image),width: 250,),
              SizedBox(height: 10,),
              Text(validatorMessage, style: AppTheme.errorMessage,),
              SizedBox(height: 10,),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppTheme.darkBlue,
                        padding: const EdgeInsets.all(10),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        validatorMessage = validator(dropDownExerciseValue, v1, v2);
                        if(validatorMessage == '') {
                          Ejercicio ej = ejercicios[int.parse(dropDownExerciseValue)];
                          String rec = v1 + ' ' + tipoRepTiempo + ' ' + v2;
                          widget.parentAction(Routine(ej.imagen, ej.nombre, ej.tipo, rec , rep_time));
                          Navigator.pop(context);
                        }
                        setState(() {

                        });
                      },
                      child: const Text('Añadir'),
                    ),
              ),
            ],
          ),
        ),
      ),

    );
  }
}

List<DropdownMenuItem<String>> getItemMuscles() {
  return [
    DropdownMenuItem(value: '', child: Text('-Seleccionar músculo-')),
    DropdownMenuItem(value: 'pecho', child: Row(children: [SizedBox(width: 10,), Image(image: AssetImage('assets/ExerciseScreenIcons/chestIconBlue.png',), width: 35,), SizedBox(width: 10,),Text('Pecho'),],)),
    DropdownMenuItem(value: 'brazos', child: Row(children: [SizedBox(width: 10,), Image(image: AssetImage('assets/ExerciseScreenIcons/armIconBlue.png',), width: 35,), SizedBox(width: 10,),Text('Brazos'),],)),
    DropdownMenuItem(value: 'abdominales', child: Row(children: [SizedBox(width: 10,), Image(image: AssetImage('assets/ExerciseScreenIcons/absIconBlue.png',), width: 35,), SizedBox(width: 10,),Text('Abdominales'),],)),
    DropdownMenuItem(value: 'espalda', child: Row(children: [SizedBox(width: 10,), Image(image: AssetImage('assets/ExerciseScreenIcons/backIconBlue.png',), width: 35,), SizedBox(width: 10,),Text('Espalda'),],)),
    DropdownMenuItem(value: 'gluteos', child: Row(children: [SizedBox(width: 10,), Image(image: AssetImage('assets/ExerciseScreenIcons/botyIconBlue.png',), width: 35,), SizedBox(width: 10,),Text('Glúteos'),],)),
    DropdownMenuItem(value: 'piernas', child: Row(children: [SizedBox(width: 10,), Image(image: AssetImage('assets/ExerciseScreenIcons/legIconBlue.png',), width: 35,), SizedBox(width: 10,),Text('Piernas'),],)),
  ];
}

List<DropdownMenuItem<String>> getItemExercises(String tipo) {
  List<DropdownMenuItem<String>> res = [DropdownMenuItem(value: '', child: Text('-Seleccionar ejercicio-'))];
  if(tipo != '') {
    List<Ejercicio> ej = Exercises.getExerciesesType(parseStringToTipo(tipo));
    for(int i = 0; i < ej.length; i++) {
      res.add(DropdownMenuItem(
          child: Row(
            children: [
              SizedBox(width: 10),
              Text(ej[i].nombre)
            ],
          ),
          value: i.toString())
      );
    }
    
  }
  
  return res;
}

List<Ejercicio> getEjerciciosByType(String tipo) {
  List<Ejercicio> res = [];

  if(tipo != '') {
    res = Exercises.getExerciesesType(parseStringToTipo(tipo));
  }
  return res;
}

String getImage(String ej, List<Ejercicio> ejercicios) {
  String res = 'assets/Fitter.png';
  if(ej != '') {
    res = ejercicios[int.parse(ej)].imagen;
  }
  return res;
}

String getRepTiempo(bool rep) {
  return rep ? 'x' : ':';
}

String validator(String ej, String v1, String v2) {
  String res = '';

  if(ej == '') {
    res += '* Debe seleccionar un ejercicio\n';
  }

  if(!inputsValidator(v1, v2)) {
    res += '* Los valores de entrada deben ser correctos';
  }
  return res;
}

bool inputsValidator(String? v1, String? v2) {
  bool validatorV1 = v1 != '' && ( 0 <= int.parse(v1!) && int.parse(v1) < 60);
  bool validatorV2 = v2 != '' && ( 0 <= int.parse(v2!) && int.parse(v2) < 60);
  print(validatorV1 && validatorV2);
  return validatorV1 && validatorV2;
}