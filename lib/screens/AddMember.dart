import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:proyecto_visitas/controller/data_controller.dart';
import 'package:proyecto_visitas/model/Visita.dart';
import 'package:proyecto_visitas/screens/MemberDetails.dart';
import 'package:proyecto_visitas/screens/MemberForm.dart';

import '../model/Tecnico.dart';

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  List<Tecnico> tecnicos = [];
  DataController dataController = DataController();
  List<Visita> lista = [];
  static int id = 0;
  static String email = "";

  loadData() async {
    id = await dataController.getUsuarioId(email);
    lista = await dataController.getVisitas(id);
  }

  Future getTecnicos() async {
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    var results = await connection.query(
        ''' SELECT (datos_personales).primer_nombre, (datos_personales).segundo_nombre, (datos_personales).primer_apellido, (datos_personales).segundo_apellido, correo FROM tecnico ''');
    for (var row in results) {
      setState(() {
        email = row[4].toString();
        tecnicos.add(Tecnico(row[0], row[1], row[2], row[3], row[4], lista));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getTecnicos();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff152534),
        title: const Text(
          'Miembros del Equipo',
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const MemberForm())),
        focusElevation: 5,
        backgroundColor: const Color(0xff55CADB),
        child: const Icon(
          Icons.add,
          size: 25,
          color: Colors.white,
        ),
      ),
      body: ListView.builder(
        itemCount: tecnicos.length,
        itemBuilder: (context, index) {
          Tecnico tec = tecnicos[index];
          return Card(
            child: ListTile(
              title: Text(
                "${tec.primer_nombre} ${tec.segundo_nombre} ${tec.primer_apellido} ${tec.segundo_apellido}",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(tec.correo),
              trailing: const Icon(Icons.chevron_right_rounded),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MemberDetails(tec),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
