import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitter/theme/app_theme.dart';
import 'package:fitter/widgets/show_error.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import '../models/usuario.dart';


class Graph extends StatefulWidget {
  final Usuario usuario;
  const Graph({Key? key, required this.usuario}) : super(key: key);

  @override
  State<Graph> createState() => _GraphState();
}

class _GraphState extends State<Graph> {
  _generateData(List<charts.Series<Peso, int>> seriesLineData) {

    var linesalesdata = listToListPeso(widget.usuario.peso);

    seriesLineData.add(
      charts.Series(
        colorFn: (__, _) => charts.Color.fromHex(code: "#F48221"),
        //colorFn: (__, _) => charts.Color.fromHex(code: "#1EBBFD"),
        id: 'Peso',
        data: linesalesdata,
        domainFn: (Peso sales, _) => sales.contador,
        measureFn: (Peso sales, _) => sales.valor,
      ),
    );

  }
  String nuevoPeso = '';
  bool error = false;
  @override
  Widget build(BuildContext context) {
    print(widget.usuario.nombre);
    List<charts.Series<Peso, int>> _seriesLineData = <charts.Series<Peso, int>>[];
    _generateData(_seriesLineData);

    return Padding(
            padding: EdgeInsets.all(10),
            child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 30,),
                      Text('Bienvenid@ ${widget.usuario.nombre}',style: TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold, color: AppTheme.blue),),
                      SizedBox(height: 5,),
                      Text('Aquí tiene una representación gráfica de su evolución',style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold, color: AppTheme.darkBlue), textAlign: TextAlign.center,),
                      SizedBox(height: 20,),
                      Container(
                        height: 350,
                        width: double.infinity,
                        child: charts.LineChart(
                                _seriesLineData,
                                primaryMeasureAxis: new charts.NumericAxisSpec(tickProviderSpec:
                                new charts.BasicNumericTickProviderSpec(zeroBound: false)),
                                defaultRenderer: new charts.LineRendererConfig(
                                    includeArea: true, stacked: true),
                                animate: true,
                                animationDuration: Duration(seconds: 1),
                                behaviors: [
                                  new charts.ChartTitle('',
                                      behaviorPosition: charts.BehaviorPosition.bottom,
                                      titleOutsideJustification:charts.OutsideJustification.middleDrawArea),
                                  new charts.ChartTitle('Peso',
                                      behaviorPosition: charts.BehaviorPosition.start,
                                      titleOutsideJustification: charts.OutsideJustification.middleDrawArea),
                                ]
                            ),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text('Añadir nuevo peso: ', style: AppTheme.defaultText,),Container(
                            width: 40,
                            height: 45,
                            child: TextFormField(
                              maxLength: 3,
                              style: TextStyle(fontSize: 20, color: AppTheme.darkBlue, fontWeight: FontWeight.bold),
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  counterText: ''
                              ),
                              onChanged: (value) {
                                nuevoPeso = value;
                              },
                            ),
                          ),
                          SizedBox(width: 10,),
                       Container(
                            child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: AppTheme.blue,
                                padding: const EdgeInsets.all(10),
                                primary: Colors.white,
                                textStyle: const TextStyle(fontSize: 17),
                                ),
                            onPressed: ()  {
                              if(nuevoPeso == ''){
                                error = true;
                              } else {
                                widget.usuario.peso.add(nuevoPeso);
                                FirebaseFirestore.instance.collection('User').doc(FirebaseAuth.instance.currentUser!.email).update({
                                  'peso' : widget.usuario.peso,
                                });
                                error = false;
                              }
                              setState(() {
                                
                              });
                            },
                            child: Text('Enviar'),
                            ),
                        ),
                      ],
                      ),
                      showError(error: error, text: 'El campo no debe ser vacío',)
                    ],
                  ),
                ),
            ),
          );
  }
}

class Peso {
  int contador;
  int valor;

  Peso(this.contador, this.valor);
}

List<Peso> listToListPeso(List<String> list) {
  List<Peso> res = [];

  for(int i = 0; i < list.length; i++) {
    res.add(Peso(i, int.parse(list[i])));
  }

  return res;
}
