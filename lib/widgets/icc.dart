import 'package:flutter/material.dart';

import '../helpers/helpers.dart';
import '../theme/app_theme.dart';
import 'show_error.dart';

class ICC extends StatefulWidget {
  const ICC({Key? key}) : super(key: key);

  @override
  State<ICC> createState() => _ICCState();
}

class _ICCState extends State<ICC> {
  String cintura = '';
  String cadera = '';
  double result = 0.0;
  bool error = false;
  bool genero = true;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Índice Cintura - Cadera'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Text('Calcula tu Índice Cintura - Cadera', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.blue),),
                SizedBox(height: 20,),
                Image.asset('assets/HomeScreenIcons/iccIcon.png', width: 100,),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Tu cintura: ', style: AppTheme.defaultText,),
                    Container(
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
                          cintura = value;
                        },
                      ),
                    ),
                    Text('cm', style: AppTheme.defaultText,)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Tu cadera: ', style: AppTheme.defaultText,),
                    Container(
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
                          cadera = value;
                        },
                      ),
                    ),
                    Text('cm', style: AppTheme.defaultText,)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Hombre', style: AppTheme.textoRecomendadoEj),
                    Radio(
                      groupValue: genero,
                      value: true,
                      onChanged: (bool? value) {
                        setState(() {
                          genero =  value!;
                        });
                      },
                    ),
                    Text('Mujer', style: AppTheme.textoRecomendadoEj),
                    Radio(
                      groupValue: genero,
                      value: false,
                      onChanged: (bool? value) {
                        setState(() {
                          genero =  value!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                showError(error: error, text: 'Los valores de entrada deben ser correctos',),
                Container(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppTheme.blue,
                      padding: const EdgeInsets.all(10),
                      primary: Colors.white,
                      textStyle: const TextStyle(fontSize: 17),
                    ),
                    onPressed: ()  {
                      if(inputOk(cintura, cadera))  {
                        result = roundDouble(double.parse(cintura)/double.parse(cadera), 2);
                        error = false;
                      } else {
                        error = true;
                        result = 0.0;
                      }
                      setState(() {

                      });
                    },
                    child: Text('CALCULAR'),
                  ),
                ),
                SizedBox(height: 20,),
                iccResult(result: result, genero: genero,),
                SizedBox(height: 30,),
                Text('El índice cintura cadera (ICC) es el cálculo que se realiza a partir de las medidas de la cintura y de la cadera para verificar el riesgo que una persona tiene de desarrollar una enfermedad cardiovascular. Esto sucede debido a que, cuanto mayor es la concentración de grasa abdominal, mayor es el riesgo de padecer problemas como colesterol alto, diabetes, presión alta o aterosclerosis'),
                Text('Tamaño de la cintura, que debe ser medida en la parte más estrecha del abdomen o en la región entre la última costilla y el ombligo'),
                Text('Tamaño de la cadera, que debe medirse en la parte más ancha de las nalgas'),
                SizedBox(height: 20,),
                Image.asset('assets/iccResult.png'),
              ],
            )
        ),
      ),
    );
  }
}

class iccResult extends StatelessWidget {
  final double result;
  final bool genero;
  const iccResult({
    Key? key, required this.result, required this.genero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(genero){
      if(0 < result && result < 0.95){
        return Text('TU ICC ES ${result}\nBAJO RIESGO DE SALUD', style: TextStyle(color: AppTheme.blue, fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center,);
      } else if(0.95 <= result && result < 1) {
        return Text('TU ICC ES ${result}\nMODERADO RIESGO DE SALUD', style: TextStyle(color: AppTheme.orange, fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center,);
      } else if( result >= 1) {
        return Text('TU ICC ES ${result}\nALTO RIESGO DE SALUD', style: TextStyle(color: AppTheme.red, fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center,);
      } else {
        return Text(' \n ');
      }
    } else {
      if(0 < result && result < 0.8){
        return Text('TU ICC ES ${result}\nBAJO RIESGO DE SALUD', style: TextStyle(color: AppTheme.blue, fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center,);
      } else if(0.8 <= result && result < 0.85) {
        return Text('TU ICC ES ${result}\nMODERADO RIESGO DE SALUD', style: TextStyle(color: AppTheme.orange, fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center,);
      } else if( result >= 0.85) {
        return Text('TU ICC ES ${result}\nALTO RIESGO DE SALUD', style: TextStyle(color: AppTheme.red, fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center,);
      } else {
        return Text(' \n ');
      }
    }
  }
}


