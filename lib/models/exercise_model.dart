enum Tipos { pecho, brazo, abdominales, espalda, gluteo ,piernas}

class Ejercicio {
  final String nombre;
  final String imagen;
  final Tipos tipo;


  Ejercicio(this.nombre, this.imagen, this.tipo);

}

class EjercicioRecomendado {
  final Ejercicio ejercicio;
  final int dificultad;
  final String recomendado;
  bool favorite;

  EjercicioRecomendado(this.ejercicio, this.dificultad, this.recomendado, this.favorite);
}