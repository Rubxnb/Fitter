import 'package:fitter/models/exercise_model.dart';
import 'package:fitter/theme/app_theme.dart';
import 'package:fitter/widgets/starsPainter.dart';
import 'package:flutter/material.dart';

class ListCardExercises extends StatefulWidget {

  final EjercicioRecomendado ej;

  const ListCardExercises({Key? key, required this.ej}) : super(key: key);

  @override
  State<ListCardExercises> createState() => _ListCardExercisesState();
}

class _ListCardExercisesState extends State<ListCardExercises> {
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(10),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
      child: Row(
        children: [
          SizedBox(width: 10,),
          ClipRRect(child: Image.asset(widget.ej.ejercicio.imagen, width: 50, height: 50,)),
          SizedBox(width: 20,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.ej.ejercicio.nombre, style: AppTheme.textoNombreEj,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  StartPainter(difficulty: widget.ej.dificultad),
                  SizedBox(width: 30,),
                  Text(widget.ej.recomendado, style: AppTheme.textoRecomendadoEj,),
                ],
              )
            ],
          ),
          Expanded(child: Container()),
          InkWell(
              child: favIconStyle(favourite: widget.ej.favorite),
              onTap: (){
                widget.ej.favorite = !widget.ej.favorite;
                setState(() {
                });
              }),
        ],
      ),
    );
  }
}

class favIconStyle extends StatelessWidget {

  bool favourite;

   favIconStyle({
    Key? key, required this.favourite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(favourite) {
      return Icon(Icons.favorite, color: AppTheme.blue, size: 40,);
    }else{
      return Icon(Icons.favorite_outline, color: AppTheme.blue, size: 40,);
    }
  }
}






