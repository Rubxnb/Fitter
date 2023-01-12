import 'package:cloud_firestore/cloud_firestore.dart';

import '../Exercises/Exercises.dart';
import '../helpers/helpers.dart';
import 'models.dart';

class MaterialQR {

  List<Ejercicio> exercises;
  String image;
  String name;
  String id;

  MaterialQR({
    required this.exercises,
    required this.image,
    required this.name,
    required this.id,
  });

   static Future<MaterialQR?> selectFromFirebase(String document) async {
     final value = await FirebaseFirestore.instance.collection('MaterialQR')
         .doc(document).get();

     if(value.exists) {
       return fromJson(value.data()!);
     }
   }

  static MaterialQR fromJson(Map<String, dynamic> json) => MaterialQR(
      exercises: Exercises.getExercisesFromList(parseToListString(json['ejercicios'])),
      image: json['imagen'],
      name: json['nombre'],
      id: json['id']);
}


