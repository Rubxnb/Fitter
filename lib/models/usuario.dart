import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitter/helpers/helpers.dart';

class Usuario {

  String email;
  List<String> peso;
  String nombre;
  String telefono;

  Usuario({required this.email, required this.peso, required this.nombre, required this.telefono});

  static Future<Usuario?> selectUsuarioFromFirebase(String document) async {
    final value = await FirebaseFirestore.instance.collection('User')
        .doc(document).get();

    if(value.exists) {
      return fromJson(value.data()!);
    }
  }

  static Usuario fromJson(Map<String, dynamic> json) => Usuario(
    email: json['email'],
    peso: parseToListString(json['peso']),
    nombre: json['nombre'],
    telefono: json['telefono']);


}