import 'package:fitter/Exercises/CalendarEvents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../Exercises/Exercises.dart';
import '../../models/exercise_model.dart';
import '../../theme/app_theme.dart';

class AddEventCalendar extends StatefulWidget {

  final DateTime? seletedDate;

  const AddEventCalendar({Key? key, required this.seletedDate}) : super(key: key);

  @override
  State<AddEventCalendar> createState() => _AddEventCalendarState();
}

class _AddEventCalendarState extends State<AddEventCalendar> {
  final formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Añadir evento', style: AppTheme.textoTitulo,),
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        backgroundColor: AppTheme.darkBlue,
        elevation: 0,
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          FormBuilder(
            child: Column(
              children: [
                FormBuilderDropdown(
                    name: 'tipo',

                  items: getTipos(),
                ),
                Divider(),
                FormBuilderTextField(
                  name: 'ejercicio',
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Añadir ejercicio',
                  ),
                ),
                Divider(),
                FormBuilderTextField(
                  name: 'descripcion',
                  maxLines: 5, minLines: 1,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Añadir descripción',
                      prefixIcon: Icon(Icons.short_text)
                  ),
                ),
                Divider(),
                FormBuilderDateTimePicker(
                    name: "date",
                    initialValue: widget.seletedDate ?? DateTime.now(),
                    fieldHintText: 'Añadir fecha',
                    inputType: InputType.date,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(Icons.calendar_today_sharp),
                    ),
                )
              ],
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(

        child: Icon(Icons.check_outlined),
        onPressed: (){
          //CalendarEvents.AddCalendarEvent( widget.seletedDate ?? DateTime.now(), event);
          Navigator.pop(context);
        },
      ),
    );
  }
}

List<DropdownMenuItem> getTipos() {
  List<DropdownMenuItem> res = [];
  List<String> tipos = ['Pecho', 'Brazos', 'Abdominales', 'Espalda', 'Glúteos', 'Piernas'];
  for(var tipo in tipos) {
    res.add(DropdownMenuItem(value:tipo ,child: Text(tipo)));
  }

  return res;
}

List<DropdownMenuItem> getEjercicios(String tipo) {
  List<DropdownMenuItem> res = [];
  List<Ejercicio> ejercicios = Exercises.getExerciesesType(getTipo(tipo));
  for(var ej in ejercicios) {
    res.add(DropdownMenuItem(value: ej ,child: Text(ej.nombre)));
  }

  return res;
}

Tipos getTipo(String tipo) {
  Tipos res = Tipos.gluteo;
  switch(tipo) {
    case 'Pecho':
      res = Tipos.pecho;
      break;
      case 'Brazos':
        res = Tipos.brazo;
        break;
        case 'Abdominales':
        res = Tipos.abdominales;
        break; 
        case 'Espalda':
        res = Tipos.espalda;
        break;
        case 'Glúteos':
        res = Tipos.gluteo;
        break;
        case 'Piernas':
        res = Tipos.piernas;
        break;
  }
  
  return res;
  
}