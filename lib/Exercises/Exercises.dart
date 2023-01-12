import '../models/models.dart';

class Exercises {
  
  static final exercises = <Ejercicio> [
    // arm
    Ejercicio('Press de hombros', 'assets/ExercisesGifs/Arms/pressGif.gif', Tipos.brazo), // 0
    Ejercicio('Fila invertida', 'assets/ExercisesGifs/Arms/invertedRowGif.gif', Tipos.brazo), // 1
    Ejercicio('Chin-up', 'assets/ExercisesGifs/Arms/chin_upGif.gif', Tipos.brazo), // 2
    Ejercicio('Curl con barra', 'assets/ExercisesGifs/Arms/curlBarraGif.gif', Tipos.brazo), // 3
    Ejercicio('Curl de un solo brazo', 'assets/ExercisesGifs/Arms/singleArmCurlGif.gif', Tipos.brazo), // 4

    // chest
    Ejercicio('Flexiones','assets/ExercisesGifs/Chest/flexionesGif.gif', Tipos.pecho), // 5
    Ejercicio('Press de pecho','assets/ExercisesGifs/Chest/pressPechoBancoGif.gif',Tipos.pecho), // 6

    // abs
    Ejercicio('Abdominales', 'assets/ExercisesGifs/Abs/absGif.gif', Tipos.abdominales),

    //

  ];

  static final ejerciciosRecomendados = <EjercicioRecomendado>  [
    // arm
    // Press de hombros
    EjercicioRecomendado(exercises[0], 1, '5 x 4', false),
    EjercicioRecomendado(exercises[0], 2, '10 x 4', true),
    // Fila invertida
    EjercicioRecomendado(exercises[1], 1, '5 x 4', false),
    // Chin-up
    EjercicioRecomendado(exercises[2], 2, '5 x 4', false),
    EjercicioRecomendado(exercises[2], 3, '10 x 4', true),
    // Curl con barra
    EjercicioRecomendado(exercises[3], 1, '5 x 4', false),
    EjercicioRecomendado(exercises[3], 2, '10 x 4', false),
    EjercicioRecomendado(exercises[3], 3, '15 x 4', false),
    // Curl de un solo brazo
    EjercicioRecomendado(exercises[4], 1, '5 x 4', true),
    EjercicioRecomendado(exercises[4], 2, '10 x 4', false),
    EjercicioRecomendado(exercises[4], 3, '15 x 4', false),

    // chest
    // Flexiones
    EjercicioRecomendado(exercises[5], 1, '5 x 4', true),
    EjercicioRecomendado(exercises[5], 2, '10 x 4', false),
    EjercicioRecomendado(exercises[5], 3, '20 x 4', false),
    // Press de pecho en banco
    EjercicioRecomendado(exercises[6], 1, '3 x 10', false),
    EjercicioRecomendado(exercises[6], 2, '6 x 10', true),
    EjercicioRecomendado(exercises[6], 3, '10 x 10', true),


    // Abdominales
    EjercicioRecomendado(exercises[7], 1, '5 x 5', false),
    EjercicioRecomendado(exercises[7], 2, '10 x 5', true),
    EjercicioRecomendado(exercises[7], 3, '20 x 5', false),

  ];

  static List<EjercicioRecomendado> getExercisesRecomendedType(Tipos tipo)  {
    List<EjercicioRecomendado> res = [];

    for(final ex in ejerciciosRecomendados) {
      if(ex.ejercicio.tipo == tipo) {
        res.add(ex);
      }
    }
    res.sort((a, b) => a.dificultad.compareTo(b.dificultad));
    return res;
  }

  static List<Ejercicio> getExerciesesType(Tipos tipo)  {
    List<Ejercicio> res = [];

    for(final ex in exercises) {
      if(ex.tipo == tipo) {
        res.add(ex);
      }
    }
    return res;
  }

  static List<EjercicioRecomendado> getFavExercisesRecomendedType(Tipos tipo)  {
    List<EjercicioRecomendado> res = [];

    for(final ex in ejerciciosRecomendados) {
      if(ex.ejercicio.tipo == tipo && ex.favorite == true) {
        res.add(ex);
      }
    }
    res.sort((a, b) => a.dificultad.compareTo(b.dificultad));
    return res;
  }

  static List<Ejercicio> getExercisesFromList(List<String> ejerciciosList) {
    List<Ejercicio> res = [];

    for(final ex in exercises) {
      if(ejerciciosList.contains(ex.nombre)) {
        res.add(ex);
      }
    }

    return res;
  }
}