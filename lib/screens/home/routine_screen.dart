import 'package:fitter/screens/exercises/add_ex_routine_screen.dart';
import 'package:fitter/theme/app_theme.dart';
import 'package:fitter/widgets/add_exercise_routine.dart';
import 'package:flutter/material.dart';

import '../../Exercises/Routines.dart';
import '../../helpers/helpers.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';


// SCREEN PRINCIPAL RUTINAS, CREO TABBAR Y SU RESPECTIVA RUTINA
class RoutineScreen extends StatefulWidget {
  const RoutineScreen({Key? key}) : super(key: key);

  @override
  State<RoutineScreen> createState() => _RoutineScreenState();
}

class _RoutineScreenState extends State<RoutineScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 7,
        child: Scaffold(
          appBar: AppBar(
            bottom: const TabBar(
              tabs: [
                Tab(text: 'L',),
                Tab(text: 'M',),
                Tab(text: 'X',),
                Tab(text: 'J',),
                Tab(text: 'V',),
                Tab(text: 'S',),
                Tab(text: 'D',),
              ],
            ),
            title: const Text('Rutina'),
          ),

          body: TabBarView(
            children: [
              RoutineDay(day: 'monday'),
              RoutineDay(day: 'tuesday'),
              RoutineDay(day: 'wednesday'),
              RoutineDay(day: 'thursday'),
              RoutineDay(day: 'friday'),
              RoutineDay(day: 'saturday'),
              RoutineDay(day: 'sunday'),
            ],
          ),


        ),

    )
    ;
  }
}

// PESTAÑA PARA CADA RUTINA
class RoutineDay extends StatefulWidget {

  final String day;

  const RoutineDay({
    Key? key, required this.day,
  }) : super(key: key);

  @override
  State<RoutineDay> createState() => _RoutineDayState();
}

class _RoutineDayState extends State<RoutineDay> {

  @override
  Widget build(BuildContext context) {

   var routine = Routines.getRoutineByDay(widget.day);

   // Update add routine to list
    _updateAddRoutineList(Routine newRoutine) {
      Routines.addRoutineByDay(widget.day, newRoutine);
      setState(() {
        routine = Routines.getRoutineByDay(widget.day);
      });
    }

    // Update remove routine from list
    _updateRemoveRoutineList(int index) {
      Routines.removeRoutinesByDay(widget.day, index) ;
      setState(() {
        routine = Routines.getRoutineByDay(widget.day);
      });
    }

    if(routine.length > 0) {
      return Scaffold(
        body: ListView.builder(
            itemCount: routine.length,
            itemBuilder: (_, index) =>
                ListTile(
              title: ListCardRoutines(day: widget.day, index: index, parentActionAddRoutine: _updateAddRoutineList, parentActionRemoveRoutine: _updateRemoveRoutineList,),

            )
        ),
        floatingActionButton: FloatingActionButton(
              child: Icon(Icons.add, size: 30),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute (
                    builder: (BuildContext context) => AddExerciseRoutine(
                        day: widget.day,
                        routines: routine,
                        parentAction: _updateAddRoutineList)));
              },
        )
      );

    } else {
      return RestDayRoutine(day: widget.day, routines: routine, parentAction: _updateAddRoutineList);
    }

  }
}


// Cards para cada rutina de la lista
class ListCardRoutines extends StatefulWidget {

  final String day;
  final int index;
  final ValueChanged<Routine> parentActionAddRoutine;
  final ValueChanged<int> parentActionRemoveRoutine;

  const ListCardRoutines({Key? key, required this.day, required this.index, required this.parentActionAddRoutine, required this.parentActionRemoveRoutine}) : super(key: key);

  @override
  State<ListCardRoutines> createState() => _ListCardRoutinesState();
}

class _ListCardRoutinesState extends State<ListCardRoutines> {
  @override
  Widget build(BuildContext context) {

    var routines = Routines.getRoutineByDay(widget.day);
    final routine = routines[widget.index];
    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.blue, width: 2),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(child: Image.asset(routine.imagen, width: 50, height: 50,)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(routine.nombre, style: AppTheme.textoNombreEj,),
              Text(routine.recomendado, style: AppTheme.textoRecomendadoEj,),

            ],
          ),
          timerButton(timer: routine.time, imageEj: routine.imagen, nombreEj: routine.nombre, timeEj: routine.recomendado),
          Column(
            children: [
              /*
              InkWell(child: Icon(Icons.edit, color: AppTheme.blue,),
              onTap: (){
                widget.parentActionAddRoutine(Routine('assets/ExercisesGifs/Arms/pressGif.gif', 'Press de hombros', Tipos.brazo, '5 x 4', true));
              }),
              SizedBox(height: 10,), */
              InkWell(child: Icon(Icons.delete, color: AppTheme.blue,),
                  onTap: (){
                   displayDialog(context, widget.day, routine.nombre, widget.index, widget.parentActionRemoveRoutine);
                  }),
            ],
          )
        ],
      ),
    );
  }
}

class timerButton extends StatefulWidget {
  final bool timer;
  final String nombreEj;
  final String imageEj;
  final String timeEj;

  const timerButton({
    Key? key, required this.timer, required this.nombreEj, required this.imageEj, required this.timeEj,
  }) : super(key: key);

  @override
  State<timerButton> createState() => _timerButtonState();
}

class _timerButtonState extends State<timerButton> {
  @override
  Widget build(BuildContext context) {
    if(widget.timer) {
      return Container(width: 20,);
    } else {
      return InkWell(child: Icon(Icons.timer_outlined, color: AppTheme.blue),
        onTap:(){
          Navigator.push(context, MaterialPageRoute (
              builder: (BuildContext context) => ChronometerExerciseScreen(
                nombreEj: widget.nombreEj,
                imageEj: widget.imageEj,
                time: widget.timeEj,)));
        },
      );
    }

  }
}

void displayDialog(BuildContext context, String titulo, String texto, int index, ValueChanged<int> parentActionRemoveRoutine) {
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text(daysTradcutor(titulo), style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.blue),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('¿Desea eliminar el ejercicio "${texto}" de la lista de rutinas?', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.darkBlue),),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () {
                  parentActionRemoveRoutine(index);
                  Navigator.pop(context);
                },
                child: Text('Aceptar')),
            TextButton(
                onPressed: () =>Navigator.pop(context),
                child: Text('Cancelar')),
          ],
        );
      }
  );
}
