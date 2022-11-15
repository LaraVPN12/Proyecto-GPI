import 'package:flutter/material.dart';
import 'package:proyecto_visitas/controller/data_controller.dart';
import 'package:proyecto_visitas/screens/Admin.dart';
import 'package:proyecto_visitas/screens/User.dart';

class RolController {
  DataController dataController = DataController();

  screenSelection(
    BuildContext context,
    String email,
  ) async {
    int id_rol = await dataController.getRol(email);
    if (id_rol > 2) {
      const UserPage();
    } else if (id_rol == 1) {
      const AdminPage();
    }
  }
}
