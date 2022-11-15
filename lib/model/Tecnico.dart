import 'package:proyecto_visitas/model/Visita.dart';

class Tecnico {
  final String primer_nombre;
  final String segundo_nombre;
  final String primer_apellido;
  final String segundo_apellido;
  final String correo;
  final List<Visita> list;

  Tecnico(
    this.primer_nombre,
    this.segundo_nombre,
    this.primer_apellido,
    this.segundo_apellido,
    this.correo,
    this.list,
  );
}
