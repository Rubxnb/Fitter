
import 'package:flutter/material.dart';

class AppTheme {

  static const Color darkBlue = Color.fromRGBO(0, 88, 161, 1);
  static const Color blue = Color.fromRGBO(30, 187, 241, 1.0);
  static const Color lightBlue = Color.fromRGBO(65, 208, 253, 1.0);
  static const Color green = Color.fromRGBO(156, 179, 39, 1);
  static const Color orange = Color.fromRGBO(244, 130, 33, 1);
  static const Color red = Color.fromRGBO(230, 70, 56, 1);
  static const Color pink = Color.fromRGBO(189, 60, 140, 1);
  static const Color purple = Color.fromRGBO(147, 61, 188, 1);


  static const TextStyle textoTitulo = TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20);

  static const TextStyle textoBotonesMenus = TextStyle(color: AppTheme.blue, fontSize: 20, fontWeight: FontWeight.bold);
  static const TextStyle defaultText = TextStyle(color: AppTheme.blue, fontSize: 18, fontWeight: FontWeight.bold);
  static const TextStyle errorMessage = TextStyle(color: Colors.red, fontWeight: FontWeight.bold);

  static const TextStyle textoNombreEj = TextStyle(color: darkBlue, fontWeight: FontWeight.bold, fontSize: 20);
  static const TextStyle textoRecomendadoEj = TextStyle(color: blue, fontWeight: FontWeight.bold, fontSize: 18);

  static InputDecoration inputDecorationTheme(String label, String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      labelText: label,
      icon: Icon(icon),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))

      )
    );
  }
}