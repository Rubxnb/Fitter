import 'dart:math';

import '../models/models.dart';
import 'package:intl/intl.dart';

//API WEB

String API = 'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAT38LINtBilzbckybZF3jBGw5ujBsO7PU';

// Parsea string a Tipo
Tipos parseStringToTipo(String tipo) {
  Tipos res = Tipos.piernas;
  switch(tipo) {
    case 'pecho':
      res = Tipos.pecho;
      break;
    case 'brazos':
      res = Tipos.brazo;
      break;
    case 'abdominales':
      res = Tipos.abdominales;
      break;
    case 'espalda':
      res = Tipos.espalda;
      break;
    case 'gluteos':
      res = Tipos.gluteo;
      break;
    case 'piernas':
      res = Tipos.piernas;
      break;

  }
  return res;
}

// Traduce los días
String daysTradcutor(String day) {
  String dia = '';

  switch(day) {
    case 'monday':
      dia = 'Lunes';
      break;
    case 'tuesday':
      dia = 'Martes';
      break;
    case 'wednesday':
      dia = 'Miércoles';
      break;
    case 'thursday':
      dia = 'Jueves';
      break;
    case 'friday':
      dia = 'Viernes';
      break;
    case 'saturday':
      dia = 'Sábado';
      break;
    case 'sunday':
      dia = 'Domingo';
      break;
  }
  return dia;
}

// Obtiene minutos y segundos de un string
int getMinutes(String time) {
  String aux = '';
  bool antes = true;

  for(var i = 0; i< time.length && antes; i++) {
    if(time[i] == ' ') {
      antes = false;
    } else {
      aux += time[i];
    }
  }
  return int.parse(aux);
}

int getSeconds(String time) {
  int aux = 0;
  bool despues = true;
  int cont = 0;

  for(var i = time.length -1 ; i >= 0 && despues; i--) {
    if(time[i] == ' ') {
      despues = false;
    } else {
      aux += int.parse(time[i]) * power(10, cont);
      cont++;
    }
  }
  return aux;
}

int power(int x, int n) {
  int retval = 1;
  for (int i = 0; i < n; i++) {
    retval *= x;
  }

  return retval;
}

String getTipoIcon(Tipos tipo) {
  String res = "";
  switch(tipo) {
    case Tipos.brazo: {
      res =  'assets/ExerciseScreenIcons/armIconBlue.png';
    }
    break;
    case Tipos.pecho: {
      res =  'assets/ExerciseScreenIcons/chestIconBlue.png';
    }
    break;
    case  Tipos.abdominales: {
      res =  'assets/ExerciseScreenIcons/absIconBlue.png';
    }
    break;
    case Tipos.espalda: {
      res =  'assets/ExerciseScreenIcons/backIconBlue.png';
    }
    break;
    case Tipos.gluteo: {
      res =  'assets/ExerciseScreenIcons/botyIconBlue.png';
    }
    break;
    case Tipos.piernas: {
      res =  'assets/ExerciseScreenIcons/legIconBlue.png';
    }
    break;
  }

  return res;
}

Map<String, int> parseToMap(Map<dynamic, dynamic> dynamic) {
  Map<String, int> res = {};
  res = dynamic.map((key, value) => MapEntry(key.toString(), int.parse(value)));

  return res;
}


List<String> parseToListString(List<dynamic> dynamic) {
  List<String> res = [];
  res = dynamic.cast<String>();
  return res;
}
double roundDouble(double value, int places){
  num mod = pow(10.0, places);
  return ((value * mod).round().toDouble() / mod);
}

double imc(String altura, String peso) =>  roundDouble(double.parse(peso) / pow((double.parse(altura)/100), 2), 2);

String dateFormatter(DateTime date) {

  return DateFormat('dd-MM-yyyy').format(date);
}

