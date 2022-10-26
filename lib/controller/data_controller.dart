import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:proyecto_visitas/components/modal.dart';
import 'package:proyecto_visitas/screens/Admin.dart';

import '../screens/User.dart';

class DataController {
  Modal dialog = new Modal();

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
      dialog.openInfoDialog(context, 'ERROR',
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
      dialog.openInfoDialog(context, 'ERROR',
          'Ya existe un usuario registrado con el correo ingresado');
      return false;
    }
  }

  Future login(BuildContext context, String correo, String password) async {
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    var results = await connection.query(
        ''' SELECT id_rol FROM usuario WHERE correo = '$correo' AND password_usuario = '$password' ''');
    if (results.isEmpty) {
      dialog.openInfoDialog(
          context, 'ERROR', 'Correo o contraseña Incorrectos');
    } else {
      for (var row in results) {
        if (row[0] > 2) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => UserPage()),
            ),
          );
        } else {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: ((context) => const AdminPage()),
            ),
          );
        }
      }
    }
  }

  Future addTecnico() async {
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    var results = await connection.query('''  ''');
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
}
