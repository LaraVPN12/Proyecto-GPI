import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_visitas/model/Tecnico.dart';
import 'package:intl/intl.dart';

import '../model/Visita.dart';

class MemberDetails extends StatelessWidget {
  final Tecnico tec;
  MemberDetails(this.tec);

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");
    DateTime date1 = dateFormat.parse("2022-10-26 20:38:10");
    DateTime date2 = dateFormat.parse("2022-11-14 15:22:58");
    final List<Visita> visitaData = [
      Visita('Centro Escolar Comunidad El Bambú', date1),
      Visita('Complejo Educativo Cantón El Sunza', date2)
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff152534),
        title: Text(
          "${tec.primer_nombre} ${tec.segundo_nombre} ${tec.primer_apellido} ${tec.segundo_apellido}",
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                child: Container(
                  height: 80,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        '2',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Visitas Realizadas',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: visitaData.length,
                itemBuilder: (context, index) {
                  Visita visita = visitaData[index];
                  DateTime dataDate = visita.fecha;
                  String formattedDate =
                      DateFormat('dd-MM-yyyy').format(dataDate);
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
