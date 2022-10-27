import 'package:flutter/material.dart';
import 'package:proyecto_visitas/screens/Admin.dart';
import 'package:proyecto_visitas/screens/Login.dart';
import 'package:proyecto_visitas/screens/MemberForm.dart';
import 'package:proyecto_visitas/screens/User.dart';

void main() => {runApp(const MyApp())};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MemberForm(),
    );
  }
}
