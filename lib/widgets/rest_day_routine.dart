import 'package:fitter/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';
import '../theme/app_theme.dart';

class RestDayRoutine extends StatefulWidget {

  final String day;
  final List<Routine> routines;
  final ValueChanged<Routine> parentAction;

  const RestDayRoutine({
    Key? key, required this.day, required this.routines, required this.parentAction,
  }) : super(key: key);

  @override
  State<RestDayRoutine> createState() => _RestDayRoutineState();
}

class _RestDayRoutineState extends State<RestDayRoutine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon( Icons.bedtime_sharp, size: 55, color: AppTheme.blue,),
            SizedBox(height: 20,),
            Text('DESCANSO', style: TextStyle(fontSize: 25, color: AppTheme.blue, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, size: 30),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute (builder: (BuildContext context) => AddExerciseRoutine(day: widget.day, routines: widget.routines, parentAction: widget.parentAction)));
        },
      )
    );
  }
}
