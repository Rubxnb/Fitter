import 'package:flutter/material.dart';

import '../helpers/helpers.dart';
import '../theme/app_theme.dart';
import 'show_error.dart';

class IMC extends StatefulWidget {
  const IMC({Key? key}) : super(key: key);

  @override
  State<IMC> createState() => _IMCState();
}

class _IMCState extends State<IMC> {
  String peso = '';
  String altura = '';
  double result = 0.0;
  bool error = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Índice de Masa Corporal'),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Text('Calcula tu Índice de Masa Corporal', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.blue),),
                SizedBox(height: 20,),
                Image.asset('assets/HomeScreenIcons/imcIcon.png', width: 100,),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Tu peso: ', style: AppTheme.defaultText,),
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
                          peso = value;
                        },
                      ),
                    ),
                    Text('kg', style: AppTheme.defaultText,)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Tu altura: ', style: AppTheme.defaultText,),
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
                          altura = value;
                        },
                      ),
                    ),
                    Text('cm', style: AppTheme.defaultText,)
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
                      if(inputOk(peso, altura))  {
                        result = imc(altura, peso);
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
                imcResult(result: result),
                SizedBox(height: 30,),
                Text('Una medida de la obesidad se determina mediante el índice de masa corporal (IMC), que se calcula dividiendo los kilogramos de peso por el cuadrado de la estatura en metros (IMC = peso [kg]/ estatura [m2])'),
                SizedBox(height: 20,),
                Image.asset('assets/imcResults.png'),
              ],
            )
        ),
      ),
    );
  }
}

class imcResult extends StatelessWidget {
  final double result;
  const imcResult({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if( 0 < result && result < 18.5) {
      return Text('TU IMC ES ${result} \nPOR DEBAJO', style: TextStyle(color: AppTheme.blue, fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center,);

    } else if(18.5 <= result && result < 25) {
      return Text('TU IMC ES ${result} \nSALUDABLE', style: TextStyle(color: AppTheme.green, fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center,);

    } else if(25 <= result && result < 30) {
      return Text('TU IMC ES ${result} \nSOBREPESO', style: TextStyle(color: AppTheme.orange, fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center,);

    } else if(30 <= result && result < 35) {
      return Text('TU IMC ES ${result} \nOBESIDAD I', style: TextStyle(color: AppTheme.red, fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center,);

    } else if(35 <= result && result <40) {
      return Text('TU IMC ES ${result} \nOBESIDAD II', style: TextStyle(color: AppTheme.pink, fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center,);

    } else if(40 <= result ) {
      return Text("TU IMC ES ${result} \nOBESIDAD III", style: TextStyle(color: AppTheme.purple, fontWeight: FontWeight.bold, fontSize: 20), textAlign: TextAlign.center,);

    } else {
      return Text(' \n ');
    }

  }
}
