import 'dart:core';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'router/routes.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Firebase.initializeApp();
  initializeDateFormatting().then((_) => runApp(MyApp()));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitter',
      initialRoute: Routes.initialRoute,
      routes: Routes.getRoutes(),
    );
  }
}