import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitter/main.dart';
import 'package:fitter/widgets/show_error.dart';
import 'package:fitter/widgets/widgets.dart';
import 'package:flutter/material.dart';

import '../screens/Singin.dart';
import '../theme/app_theme.dart';

class Login extends StatefulWidget {
  const Login({
    Key? key,
  }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();

}



class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passWordController = TextEditingController();

  void dispose()
  {
    emailController.dispose();
    passWordController.dispose();

    super.dispose();
  }

  bool isLoading = false;
  bool error = false;

  @override
  Widget build(BuildContext context) {

    return isLoading ? LoadingScreen() : Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40,),
              Image.asset('assets/Fitter.png', width: 200,),
              SizedBox(height: 20,),
              CustomInputField(label: 'E-mail', hint: 'example@gmail.com',icon: Icons.alternate_email_outlined, tipo: TextInputType.emailAddress, controller: emailController,),
              SizedBox(height: 20,),
              CustomInputField(label: 'Contraseña', hint: '**********',icon: Icons.lock, tipo: TextInputType.visiblePassword, controller: passWordController,),
              SizedBox(height: 20,),
              showError(error: error, text: 'E-mail y/o contraseña incorrectos'),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child:
                  Container(
                    width: double.infinity,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: AppTheme.blue,
                        padding: const EdgeInsets.all(10),
                        primary: Colors.white,
                        textStyle: const TextStyle(fontSize: 17),
                      ),
                      onPressed: () async{
                        signIn();
                        setState(() => isLoading = true);

                        await Future.delayed(Duration(seconds: 2));
                        setState(() => isLoading = false);
                      },
                      child: Text('INICIAR SESIÓN'),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('¿Aún no tienes cuenta?', style: TextStyle(color: AppTheme.blue),),
                  TextButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute (builder: (BuildContext context) => Singin()));

                  },
                      child: Text('CREAR CUENTA', style: TextStyle(decoration: TextDecoration.underline, fontSize: 17,color: AppTheme.darkBlue, fontWeight: FontWeight.bold),)),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passWordController.text.trim());
    } catch (e) {
      error = true;
      setState((){});
      print(e);
    }
  }
}
