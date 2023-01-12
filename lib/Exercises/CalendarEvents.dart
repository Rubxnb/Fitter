import '../models/models.dart';

class CalendarEvents  {
  
  static Map<String, List<Routine>> calendarEvents = {
    '24-05-2022' : [Routine('assets/ExercisesGifs/Arms/pressGif.gif', 'Press de hombros', Tipos.brazo, '5 x 4', true),],
  };
  static Map<String, List<Tipos>> calendarTypes = {
    '24-05-2022' : [Tipos.piernas, Tipos.abdominales],
  };

  
  static AddCalendarEvent(String date, Tipos tipo) {
    if(calendarTypes.isEmpty || !calendarTypes.containsKey(date)) {
      calendarTypes[date] = [tipo];
    } else {
      calendarTypes[date]!.add(tipo);
    }
  }

  static List<Tipos> getEvents(String date) {
    List<Tipos> res = [];
      if(!calendarTypes.isEmpty && calendarTypes.containsKey(date)) {
        res = calendarTypes[date]!;
      }
    return res;
  }
}