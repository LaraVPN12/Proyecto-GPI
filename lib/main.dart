// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:proyecto_visitas/controller/rol_controller.dart';
import 'package:proyecto_visitas/screens/Principal.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => {runApp(const MyApp())};

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  RolController rolController = RolController();

  loadPreferences() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? value = preferences.getString("email");
    if (value != null) {
      setState(() {
        rolController.screenSelection(context, value);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadPreferences();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Principal(),
    );
  }
}
