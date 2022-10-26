import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postgres/postgres.dart';
import 'package:proyecto_visitas/services/DBConnection.dart';

class DataController {
  // ignore: non_constant_identifier_names
  Future tecnico_exist(String nombre, String apellido, String email,
      BuildContext context) async {
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
      openDialog(context, 'ERROR',
          'Los datos del usuario ingresados no se encontraron');
    }
  }

  Future<bool> user_exist(String email, BuildContext context) async {
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    var results = await connection
        .query('''SELECT * FROM usuario WHERE correo = '$email' ''');
    if (results.isEmpty) {
      return Future<bool>.value(true);
    } else {
      openDialog(context, 'ERROR',
          'Ya existe un usuario registrado con el correo ingresado');
      return false;
    }
  }

  Future addUser() async {
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    var results = await connection.query(''' INSERT INTO  ''');
  }

  Future getUserInfo(String email, String password) async {
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    var results = await connection.query(
        '''' SELECT * FROM usuario WHERE correo = '$email' AND password_usuario = '$password' ''');
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
                Text(
                  titulo,
                  style: TextStyle(
                    color: Colors.red[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  contenido,
                  textAlign: TextAlign.center,
                ),
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
