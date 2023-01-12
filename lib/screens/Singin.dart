import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/show_error.dart';
import '../widgets/widgets.dart';

class Singin extends StatefulWidget {
  const Singin({Key? key}) : super(key: key);

  @override
  State<Singin> createState() => _SinginState();
}

class _SinginState extends State<Singin> {

  final nameController = TextEditingController();
  final tlfController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();

  bool isLoading = false;
  bool error = false;
  String validation = '';

  @override
  Widget build(BuildContext context) {
    return isLoading ? LoadingScreen() : Scaffold(
      appBar: AppBar(
        title: Text('Crear cuenta'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 40,),
              CustomInputField(label: 'Nombre', hint: 'John Smith',icon: Icons.person,tipo: TextInputType.text, controller: nameController,),
              SizedBox(height: 20,),
              CustomInputField(label: 'Teléfono', hint: '666666666',icon: Icons.phone,tipo: TextInputType.number, controller: tlfController,),
              SizedBox(height: 20,),
              CustomInputField(label: 'E-mail', hint: 'example@gmail.com',icon: Icons.alternate_email_outlined,tipo: TextInputType.emailAddress, controller: emailController,),
              SizedBox(height: 20,),
              CustomInputField(label: 'Contraseña', hint: '**********',icon: Icons.lock, tipo: TextInputType.visiblePassword, controller: passwordController,),
              SizedBox(height: 20,),
              CustomInputField(label: 'Confirmar contraseña', hint: '**********',icon: Icons.lock, tipo: TextInputType.visiblePassword, controller: passwordConfirmController,),
              SizedBox(height: 20,),
              showError(error: error, text: validation),
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
                        validation = validateFields(emailController.text.trim(), nameController.text.trim(), passwordController.text.trim(), tlfController.text.trim(), passwordConfirmController.text.trim());
                        if(validation == '') {
                          signUp();
                          setState(() => isLoading = true);

                          await Future.delayed(Duration(seconds: 2));
                          setState(() => isLoading = false);

                          error = true;
                          validation = 'Dirección de correo electrónico existente';
                        } else {
                          error = true;
                        }

                        setState(() {

                        });

                      },
                      child: Text('CREAR CUENTA'),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('¿Ya tienes cuenta?', style: TextStyle(color: AppTheme.blue),),
                  TextButton(onPressed: (){
                    Navigator.pop(context);
                  },
                      child: Text('INICIAR SESIÓN', style: TextStyle(fontSize: 17,color: AppTheme.darkBlue, fontWeight: FontWeight.bold),)),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future signUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim()
      );
      createUser(emailController.text.trim(), nameController.text.trim(), tlfController.text.trim());
      Navigator.pop(context);
    } catch (e) {
      error = true;
      validation = 'Dirección de correo electrónico existente';
      setState((){});
      print(e);
    }
  }
}

Future createUser(String email, String nombre, String tlf) async {
  final docUser = FirebaseFirestore.instance.collection('User').doc(email);

  final json = {
    'email': email,
    'nombre' : nombre,
    'peso' : [],
    'telefono': tlf
  };

  await docUser.set(json);

}
String validateFields(String email, String nombre, String pass, String tlf, String passValidate) {
  String res = '';
  if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email)){
    res += 'Introduce una dirección de correo electrónico válida\n';
  };
  if(nombre.length ==0) {
    res += 'Introduce un nombre\n';
  }
  if(tlf.length != 9) {
    res += 'Introduce un teléfono correcto\n';
  }
  if(pass.length < 6) {
    res += 'Introduce una contraseña de longitud mayor a 5\n';
  }

  if(pass != passValidate) {
    res += 'Ambas contraseñas deben ser iguales\n';
  }

  return res;
}

