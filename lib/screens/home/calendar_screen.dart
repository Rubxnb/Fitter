import 'package:fitter/widgets/background.dart';
import 'package:fitter/widgets/event_card_calendar.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Exercises/CalendarEvents.dart';
import '../../helpers/helpers.dart';
import '../../models/exercise_model.dart';
import '../../models/routine_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/widgets.dart';
import '../exercises/add_event_calendar.dart';

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  List<Tipos> listEvents = CalendarEvents.getEvents((dateFormatter(DateTime.now())));

  _AddTipo(Tipos tipo) {
    CalendarEvents.AddCalendarEvent(dateFormatter(_selectedDay), tipo);
    //listEvents.add(tipo);
    setState(() {
      listEvents = CalendarEvents.getEvents(dateFormatter(_selectedDay));
    });
  }

  @override
  Widget build(BuildContext context) {
    print(CalendarEvents.calendarTypes);
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendario', style: AppTheme.textoTitulo,),
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        backgroundColor: AppTheme.darkBlue,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Background(),
          SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  child: TableCalendar(
                    locale: 'es_ES',
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                    headerStyle: HeaderStyle(
                      headerMargin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: AppTheme.lightBlue,

                      ),
                      titleCentered: true,
                      formatButtonVisible: false,
                    ),

                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    if (!isSameDay(_selectedDay, selectedDay)) {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      listEvents = CalendarEvents.getEvents(dateFormatter(_selectedDay!));
                      setState(() {

                      });
                    }
                  },

                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },),
                clipBehavior: Clip.antiAlias,
                margin: EdgeInsets.all(10),
                ),
                SizedBox(
                  height: 400,
                  child: GridView.count(
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    padding: EdgeInsets.all(10),
                    crossAxisCount: 4,
                    children: List.generate(listEvents.length, (index) {
                      return CardTypes(tipo: listEvents[index],);
                    }),
                  ),
                ),


              ],
            ),
          ),
        ]
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppTheme.lightBlue,
        child: Icon(Icons.add),
        onPressed: () {
          print(_selectedDay);
          displayDialogCalendar(context, _AddTipo);
          setState(() {

          });
          //Navigator.push(context, MaterialPageRoute (builder: (BuildContext context) => AddEventCalendar(seletedDate: _selectedDay,)));
        },
      ),
    );
  }
}


class CardTypes extends StatelessWidget {
  final Tipos tipo;
  const CardTypes({Key? key, required this.tipo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        border: Border.all(color: AppTheme.blue, width: 2),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Image.asset(getTipoIcon(tipo),)
    );
  }
}

void displayDialogCalendar(BuildContext context, ValueChanged<Tipos> parentActionAddTipo) {
  Tipos tipo = Tipos.abdominales;
  String dropDownTiposValue = '';
  showDialog(
      barrierDismissible: true,
      context: context,
      builder: (context) {
        return AlertDialog(
          elevation: 5,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          title: Text('Añadir tipo de ejercicio', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.blue),),
          content: Container(
            child: DropdownButton(
              style: const TextStyle(color: AppTheme.blue, fontSize: 18, fontWeight: FontWeight.bold),
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppTheme.blue,),
              underline: Container(
                height: 2,
                color: AppTheme.blue,
              ),
              value: dropDownTiposValue,
              items: getItemMuscles(),
              onChanged: (String? newValue) {
                  dropDownTiposValue = newValue!;
                  tipo = parseStringToTipo(dropDownTiposValue);
              },
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  parentActionAddTipo(tipo);
                  Navigator.pop(context);
                },
                child: Text('Añadir')),
            TextButton(
                onPressed: () =>Navigator.pop(context),
                child: Text('Cancelar')),
          ],
        );
      }
  );
}
