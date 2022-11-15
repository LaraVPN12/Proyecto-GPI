import 'package:flutter/material.dart';
import 'package:proyecto_visitas/controller/TextFieldController.dart';
import 'package:intl/intl.dart';
import 'package:proyecto_visitas/controller/data_controller.dart';
import 'package:proyecto_visitas/screens/User.dart';

class Modal {
  TextFieldController controller = TextFieldController();
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  String mes = DateFormat('MMMM').format(DateTime.now());
  static String nombreEscuela = "";
  static int idEscuela = 0, idUsuario = 0;
  Future openInfoDialog(
          BuildContext context, String titulo, String contenido) =>
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  titulo,
                  style: TextStyle(
                    color: Colors.red[400],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  contenido,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cerrar'),
                ),
              ],
            ),
          ),
        ),
      );

  Future openInputDialog(
    BuildContext context,
    String titulo,
    String contenido,
    String email,
    DataController dataController,
  ) =>
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 25,
            ),
            child: Form(
              key: controller.formkey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    titulo,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff152534),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Text(
                      'Fecha: $formattedDate',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: controller.nameController,
                      onSaved: (value) {
                        controller.name = value!;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        labelText: 'Nombre del Centro Escolar',
                      ),
                      obscureText: false,
                      validator: (value) {
                        nombreEscuela = value!;
                        return controller.validateName(value);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancelar'),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xff55CADB)),
                        ),
                        onPressed: () async {
                          if (controller.checkLogin(context)) {
                            idEscuela = await dataController
                                .getEscuelaId(nombreEscuela);
                            idUsuario =
                                await dataController.getUsuarioId(email);
                            dataController.addVisita(
                              idEscuela,
                              DateTime.now(),
                              mes,
                              idUsuario,
                            );
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const UserPage()),
                                (route) => false);
                          }
                        },
                        child: const Text('Ingresar'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
