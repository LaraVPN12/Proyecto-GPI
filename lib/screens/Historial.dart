import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:postgres/postgres.dart';
import 'package:proyecto_visitas/model/Visita.dart';

class Historial extends StatelessWidget {
  const Historial({super.key});

  @override
  Widget build(BuildContext context) {
    return const HistorialCards();
  }
}

class HistorialCards extends StatefulWidget {
  const HistorialCards({super.key});

  @override
  State<HistorialCards> createState() => _HistorialCardsState();
}

class _HistorialCardsState extends State<HistorialCards> {
  List<Visita> visitas = [];
  @override
  void initState() {
    super.initState();
    getVisitas();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  Future getVisitas() async {
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    var results = await connection.query(
        ''' SELECT nombre_escuela, fecha FROM visita vv INNER JOIN escuela ee ON vv.id_escuela = ee.id_escuela ''');
    for (var row in results) {
      setState(() {
        visitas.add(Visita(row[0], row[1]));
      });
    }
    await connection.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Historial de Visitas"),
      ),
      body: ListView.builder(
        itemCount: visitas.length,
        itemBuilder: (context, index) {
          Visita visita = visitas[index];
          DateTime dbDate = visita.fecha;
          String formattedDate = DateFormat('dd-MM-yyyy').format(dbDate);
          return Card(
            child: ListTile(
              title: Text(
                visita.nombreEscuela,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(formattedDate),
            ),
          );
        },
      ),
    );
  }
}
