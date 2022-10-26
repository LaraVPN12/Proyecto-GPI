import 'package:flutter/material.dart';
import 'package:proyecto_visitas/components/modal.dart';

class AddRegister extends StatefulWidget {
  const AddRegister({super.key});

  @override
  State<AddRegister> createState() => _AddRegisterState();
}

class _AddRegisterState extends State<AddRegister> {
  Modal dialog = Modal();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          dialog.openInputDialog(
              context, 'Nueva Visita', 'Ingrese el nombre del Centro Escolar');
        },
        focusElevation: 5,
        backgroundColor: Colors.greenAccent[400],
        child: const Icon(
          Icons.add,
          size: 25,
          color: Colors.white,
        ),
      ),
    );
  }
}
