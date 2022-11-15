import 'package:flutter/material.dart';
import 'package:proyecto_visitas/model/Escuela.dart';

class Escuelas extends StatelessWidget {
  const Escuelas({super.key});

  @override
  Widget build(BuildContext context) {
    List<Escuela> escuelaData = [
      Escuela('Complejo Educativo Cantón Palo Combo', 3),
      Escuela('Complejo Educativo Cantón San Isidro', 5),
      Escuela('Centro Escolar Comunidad El Bambú', 4),
      Escuela('Complejo Educativo Cantón El Sunza', 1)
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Centros Escolares Visitados'),
        backgroundColor: const Color(0xff152534),
      ),
      body: ListView.builder(
        itemCount: escuelaData.length,
        itemBuilder: (context, index) {
          Escuela escuela = escuelaData[index];
          return Card(
            child: ListTile(
              title: Text(
                escuela.nombreEscula,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                'Cantidad Visitas: ${escuela.cantidadVisitas}',
              ),
            ),
          );
        },
      ),
    );
  }
}
