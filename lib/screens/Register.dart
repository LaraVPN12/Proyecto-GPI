// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:proyecto_visitas/controller/TextFieldController.dart';
import 'package:proyecto_visitas/screens/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/data_controller.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  DataController dataController = DataController();
  late String primer_nombre,
      segundo_nombre,
      primer_apellido,
      segundo_apellido,
      email,
      password;
  TextFieldController controller = TextFieldController();
  List<String> rolItems = [];
  List<String> areaItems = [];
  String? value;

  Future getRol() async {
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    var results =
        await connection.query('''SELECT * FROM rol WHERE id_rol > 2''');
    for (var row in results) {
      setState(() {
        rolItems.add(row[1]);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getRol();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Form(
              key: controller.formkey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  const Text(
                    'Regístrate',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //Primer Nombre
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
                        labelText: 'Primer Nombre',
                      ),
                      obscureText: false,
                      validator: (value) {
                        primer_nombre = value!;
                        return controller.validateName(value);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //Segundo Nombre
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
                        labelText: 'Segundo Nombre',
                      ),
                      obscureText: false,
                      validator: (value) {
                        segundo_nombre = value!;
                        return controller.validateName(value);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //Primer Apellido
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
                        labelText: 'Primer Apellido',
                      ),
                      obscureText: false,
                      validator: (value) {
                        primer_apellido = value!;
                        return controller.validateLastName(value);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //Segundo Apellido
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
                        labelText: 'Seguro Apellido',
                      ),
                      obscureText: false,
                      validator: (value) {
                        segundo_apellido = value!;
                        return controller.validateLastName(value);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //Email
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: controller.emailController,
                      onSaved: (value) {
                        controller.email = value!;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        labelText: 'Email',
                      ),
                      obscureText: false,
                      validator: (value) {
                        email = value!;
                        return controller.validateEmail(value);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  //Password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: controller.passwordController,
                      onSaved: (value) {
                        controller.password = value!;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        labelText: 'Password',
                      ),
                      obscureText: true,
                      validator: (value) {
                        password = value!;
                        return controller.validatePassword(value);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  DropDownRegisterItem('Cargo', rolItems),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: (() async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      preferences.setString("email", email);
                      if (controller.checkLogin(context)) {
                        dataController.tecnico_exist(
                            primer_nombre, primer_apellido, email, context);
                        var res =
                            await dataController.user_exist(email, context);
                        if (res) {
                          var rolId = await dataController.getRolId(value!);
                          dataController.addUser(
                            primer_nombre,
                            segundo_nombre,
                            primer_apellido,
                            segundo_apellido,
                            email,
                            password,
                            rolId,
                          );
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const UserPage(),
                            ),
                          );
                        }
                      }
                    }),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: const Color(0xff152534),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Crear Cuenta',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Padding DropDownRegisterItem(String itemName, List<String> items) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            itemName,
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey[100]?.withOpacity(0.5),
              border: Border.all(
                width: 2.0,
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                hint: const Text('Seleccione una opción'),
                value: value,
                isExpanded: true,
                items: items.map(buildMenuItem).toList(),
                onChanged: (value) => setState(() => this.value = value),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
        ),
      );
}
