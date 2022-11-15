import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:proyecto_visitas/components/modal.dart';
import 'package:proyecto_visitas/model/Visita.dart';
import 'package:proyecto_visitas/screens/Admin.dart';

import '../model/Area.dart';
import '../screens/User.dart';

class DataController {
  Modal dialog = new Modal();

  Future tecnico_exist(
    String nombre,
    String apellido,
    String email,
    BuildContext context,
  ) async {
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
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const UserPage()),
              (route) => false);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const AdminPage()),
              (route) => false);
        }
      }
    }
  }

  Future<int> getAreaId(String area) async {
    var value;
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    var results = await connection.query(
        ''' SELECT id_area_educativa FROM area_educativa WHERE nombre_area_educativa = '$area' ''');
    for (var row in results) {
      value = await Future<String>.value(row[0]);
    }
    await connection.close();
    return value;
  }

  Future<String> getAreaName(int id) async {
    var value;
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    var results = await connection.query(
        ''' SELECT nombre_area_educativa FROM area_educativa WHERE id_area_educativa = '$id' ''');
    for (var row in results) {
      value = await Future<String>.value(row[0]);
    }
    await connection.close();
    return value;
  }

  Future<bool> getAreasSelected(
      int id_area_educativa, BuildContext context) async {
    var value;
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    var results = await connection.query(
        ''' SELECT * FROM relacion_tecnico_area WHERE id_area_educativa = '$id_area_educativa' ''');
    if (results.isEmpty) {
      return Future<bool>.value(true);
    } else {
      value = await getAreaName(id_area_educativa);
      dialog.openInfoDialog(
          context, 'ERROR', 'El $value ya ha sido registrada');
      return false;
    }
  }

  Future addTecnico(
    String primer_nombre,
    String segundo_nombre,
    String primer_apellido,
    String segundo_apellido,
    String correo,
  ) async {
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    await connection.query(
        ''' INSERT INTO tecnico (datos_personales.primer_nombre, datos_personales.segundo_nombre, datos_personales.primer_apellido, datos_personales.segundo_apellido, correo) VALUES('$primer_nombre', '$segundo_nombre', '$primer_apellido', '$segundo_apellido', '$correo')''');
    await connection.close();
  }

  Future<int> getTecnicoId(String correo) async {
    var value;
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    var results = await connection
        .query(" SELECT id_tecnico FROM tecnico WHERE correo = '$correo' ");
    if (results.isNotEmpty) {
      for (var row in results) {
        value = await Future<int>.value(row[0]);
      }
    } else {
      value = 0;
    }
    await connection.close();
    return value;
  }

  Future addRelation(List<Area> items, String correo) async {
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    for (var row in items) {
      await connection.query(
          " INSERT INTO relacion_tecnico_area (id_tecnico, id_area_educativa) VALUES('${getTecnicoId(correo)}', '${row.title}') ");
    }
    await connection.close();
  }

  Future<int> getRolId(String rol) async {
    var value;
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    var results =
        await connection.query(" SELECT id_rol FROM rol WHERE rol = '$rol' ");
    if (results.isNotEmpty) {
      for (var row in results) {
        value = await Future<int>.value(row[0]);
      }
    } else {
      value = 0;
    }
    await connection.close();
    return value;
  }

  Future<int> getRol(String correo) async {
    var value;
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    var results = await connection
        .query(" SELECT id_rol FROM usuario WHERE correo = '$correo' ");
    if (results.isNotEmpty) {
      for (var row in results) {
        value = Future<int>.value(row[0]);
      }
    } else {
      value = 0;
    }
    await connection.close();
    return value;
  }

  Future<List<Visita>> getVisitas(int id) async {
    List<Visita> list = [];
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    var results = await connection.query(
        ''' SELECT nombre_escuela, fecha FROM visita vv INNER JOIN escuela ee ON vv.id_escuela = ee.id_escuela WHERE id_usuario = '$id' ''');
    for (var row in results) {
      list.add(
        Visita(row[0], row[1]),
      );
    }
    return list;
  }

  Future<int> getAmountByUser(int id) async {
    var value;
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    var results = await connection
        .query(''' SELECT COUNT(*) FROM visita WHERE id_usuario = '$id' ''');
    if (results.isNotEmpty) {
      for (var row in results) {
        value = Future<int>.value(row[0]);
      }
    } else {
      value = 0;
    }
    await connection.close();
    return value;
  }

  Future<int> getAmount() async {
    var value;
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    var results = await connection.query(''' SELECT COUNT(*) FROM visita ''');
    if (results.isNotEmpty) {
      for (var row in results) {
        value = Future<int>.value(row[0]);
      }
    } else {
      value = 0;
    }
    await connection.close();
    return value;
  }

  Future<int> getUsuarioId(String email) async {
    var value;
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    var results = await connection
        .query(''' SELECT id_usuario FROM usuario WHERE correo = '$email' ''');
    if (results.isNotEmpty) {
      for (var row in results) {
        value = Future<int>.value(row[0]);
      }
    } else {
      value = 0;
    }
    await connection.close();
    return value;
  }

  Future<int> getEscuelaId(String nombreEscuela) async {
    var value;
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    var results = await connection.query(
        '''  SELECT id_escuela FROM escuela WHERE nombre_escuela = '$nombreEscuela' ''');
    if (results.isNotEmpty) {
      for (var row in results) {
        value = Future<int>.value(row[0]);
      }
    } else {
      value = 0;
    }
    await connection.close();
    return value;
  }

  Future addUser(
    String primerNombre,
    String segundoNombre,
    String primerApellido,
    String segundoApellido,
    String correo,
    String password,
    int rol,
  ) async {
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    await connection.query(
        ''' INSERT INTO usuario (datos_personales.primer_nombre, datos_personales.segundo_nombre, datos_personales.primer_apellido, datos_personales.segundo_apellido, correo, password_usuario, id_rol) VALUES ('$primerNombre', '$segundoNombre', '$primerApellido', '$segundoApellido', '$correo', '$password', '$rol') ''');
    await connection.close();
  }

  Future<int> getAmountByMonth(String month) async {
    var value;
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    var results = await connection
        .query('''  SELECT COUNT(*) FROM visita WHERE mes = '$month' ''');
    if (results.isNotEmpty) {
      for (var row in results) {
        value = Future<int>.value(row[0]);
      }
    } else {
      value = 0;
    }
    await connection.close();
    return value;
  }

  Future addVisita(
    int idEscuela,
    DateTime fecha,
    String mes,
    int idUsuario,
  ) async {
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    await connection.query(
        ''' INSERT INTO visita (id_escuela, fecha, mes, id_usuario) VALUES ('$idEscuela', '$fecha', '$mes', '$idUsuario') ''');
    await connection.close();
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
    await connection.close();
  }
}
