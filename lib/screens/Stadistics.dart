import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:postgres/postgres.dart';
import 'package:proyecto_visitas/model/Estadistica.dart';
import 'package:proyecto_visitas/screens/Escuelas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../components/ChartCategories.dart';
import '../components/ChartView.dart';
import '../controller/data_controller.dart';

class Stadistics extends StatelessWidget {
  const Stadistics({super.key});

  @override
  Widget build(BuildContext context) {
    return const StatsItems();
  }
}

class StatsItems extends StatefulWidget {
  const StatsItems({super.key});

  @override
  State<StatsItems> createState() => _StatsItemsState();
}

class _StatsItemsState extends State<StatsItems> {
  late List<Estadistica> _chartData;
  late TooltipBehavior _tooltipBehavior;
  static String email = "";
  SharedPreferences? preferences;
  DataController dataController = DataController();
  String month = DateFormat('MMMM').format(DateTime.now());
  static int id = 0, cantidadVisitas = 0, cantidadVisitasMes = 0;
  List<Estadistica> statItems = [];

  @override
  void initState() {
    super.initState();
    _chartData = getChartData();
    _tooltipBehavior = TooltipBehavior(enable: true);
    loadPreferences();
    loadData();
  }

  Future loadPreferences() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences!.getString("email")!;
    });
  }

  loadData() async {
    id = await dataController.getUsuarioId(email);
    cantidadVisitas = await dataController.getAmount();
    cantidadVisitasMes = await dataController.getAmountByMonth(month);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff152534),
        title: const Text('Estadísticas'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            height: height,
            child: Column(
              children: [
                SfCircularChart(
                  legend: Legend(
                    isVisible: true,
                    overflowMode: LegendItemOverflowMode.wrap,
                  ),
                  tooltipBehavior: _tooltipBehavior,
                  series: <CircularSeries>[
                    DoughnutSeries<Estadistica, String>(
                      dataSource: _chartData,
                      xValueMapper: (Estadistica data, _) => data.mes,
                      yValueMapper: (Estadistica data, _) => data.cantidad,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                      ),
                      enableTooltip: true,
                    ),
                  ],
                ),
                Container(
                  height: 80,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.amber[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        cantidadVisitas.toString(),
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        'Visitas Realizadas',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 80,
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        cantidadVisitasMes.toString(),
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        'Visitas del mes',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.home_work_rounded),
                    title: const Text(
                      'Visitas a Centros Escolares',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(
                      Icons.chevron_right_outlined,
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Escuelas(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<Estadistica> getChartData() {
  final List<Estadistica> chartData = [
    Estadistica('Agosto', 40),
    Estadistica('Septiembre', 25),
    Estadistica('Octubre', 38),
    Estadistica('Novimbre', 10)
  ];
  return chartData;
}
