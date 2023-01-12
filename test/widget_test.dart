// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';

import 'package:fitter/main.dart';
import 'package:fitter/helpers/helpers.dart';
import 'package:test/test.dart';

void main() {
  test('Cálculo IMC no valido', () {
    String peso = '65';
    String altura = '175';
    expect(imc(altura, peso), 2);
  });

  test('Cálculo IMC válido', () {
    String peso = '65';
    String altura = '175';
    expect(imc(altura, peso), 21.22);
  });
}
