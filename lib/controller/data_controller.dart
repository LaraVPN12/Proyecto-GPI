import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postgres/postgres.dart';
import 'package:proyecto_visitas/services/DBConnection.dart';

class DataController {
  // ignore: non_constant_identifier_names
  Future user_exist(
      String nombre, String apellido, BuildContext context) async {
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    var results = await connection.query(
        '''SELECT * FROM tecnico WHERE (datos_personales).primer_nombre = '$nombre' AND (datos_personales).primer_apellido = '$apellido' ''');
    if (results.isEmpty) {
      openDialog(context, 'ERROR', 'Los no ' + nombre + ' ' + apellido);
    } else {
      openDialog(context, 'BIEN', 'Los datos fueron encontrados');
    }
  }

  Future openDialog(BuildContext context, String titulo, String contenido) =>
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(titulo),
                const SizedBox(
                  height: 10,
                ),
                Text(contenido),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cerrar'),
                ),
              ],
            ),
          ),
        ),
      );
}
