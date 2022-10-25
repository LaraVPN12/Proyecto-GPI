import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proyecto_visitas/services/DBConnection.dart';

class DataController {
  DBConnection db = DBConnection();
  Future user_exist(
      String nombre, String apellido, BuildContext context) async {
    await db.connection.open();
    var results = await db.connection.query(
        "SELECT * FROM tecnico WHERE (datos_personales).primer_nombre = '$nombre'");
    if (results.isEmpty) {
      openDialog(context, 'ERROR', 'Los datos no fueron encontrados');
    } else {
      print("Well Done");
      //await db.connection.close();
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
