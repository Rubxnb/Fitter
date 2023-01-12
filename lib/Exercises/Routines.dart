
import 'package:fitter/models/exercise_model.dart';

import '../models/routine_model.dart';

class Routines{

  static final Map<String, List<Routine>> routines = {
    'monday' : [Routine('assets/ExercisesGifs/Arms/pressGif.gif', 'Press de hombros', Tipos.brazo, '5 x 4', true), ],
    'tuesday' : [],
    'wednesday' : [],
    'thursday' : [],
    'friday' : [],
    'saturday' : [],
    'sunday' : [],
  };

  static List<Routine>  getRoutineByDay(String day) {
    return routines[day]!;
  }

  static addRoutineByDay(String day, Routine routine) {
    routines[day]!.add(routine);
  }

  static removeRoutinesByDay(String day, int index) {
    routines[day]!.removeAt(index);
  }
}