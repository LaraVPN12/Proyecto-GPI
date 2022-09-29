import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:proyecto_visitas/components/CustomButtom.dart';
import 'package:proyecto_visitas/components/CustomTextField.dart';
import '../components/RegisterItem.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
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
    var results = await connection.query('''SELECT * FROM rol''');
    for (var row in results) {
      setState(() {
        rolItems.add(row[1]);
      });
    }
    await connection.close();
  }

  @override
  void initState() {
    super.initState();
    getRol();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
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
                  height: 10,
                ),
                //Name
                RegisterItem(
                  itemName: 'Nombre',
                  textField: CustomTextField(
                    placeholder: 'Nombre',
                  ),
                ),
                //Email
                RegisterItem(
                  itemName: 'Email',
                  textField: CustomTextField(
                    placeholder: 'Email',
                  ),
                ),
                RegisterItem(
                  itemName: 'Usuario',
                  textField: CustomTextField(
                    placeholder: 'Nombre de Usuario',
                  ),
                ),
                RegisterItem(
                  itemName: 'Contraseña',
                  textField: CustomTextField(
                    placeholder: 'Contraseña',
                    hidetext: true,
                  ),
                ),
                DropDownRegisterItem('Cargo', rolItems),
                const SizedBox(
                  height: 10,
                ),
                const CustomButtom(
                  text: 'Hecho',
                ),
              ],
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
