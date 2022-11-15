import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:proyecto_visitas/controller/data_controller.dart';
import 'package:proyecto_visitas/screens/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  static String name = "", lastName = "", email = "";
  SharedPreferences? preferences;
  DataController dataController = DataController();
  static int id = 0, cantidadVisitas = 0;

  @override
  void initState() {
    super.initState();
    loadPreferences();
    loadData();
    getUserInfo();
  }

  loadPreferences() async {
    preferences = await SharedPreferences.getInstance();
    setState(() {
      email = preferences!.getString("email")!;
    });
  }

  loadData() async {
    id = await dataController.getUsuarioId(email);
    cantidadVisitas = await dataController.getAmountByUser(id);
    setState(() {});
  }

  Future getUserInfo() async {
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    var results = await connection.query(
        ''' SELECT (datos_personales).primer_nombre, (datos_personales).primer_apellido FROM usuario WHERE correo = '$email' ''');
    for (var row in results) {
      name = row[0];
      lastName = row[1];
    }
    await connection.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Perfil',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
              width: 150.0,
              height: 150.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=880&q=80'),
                ),
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(100.0),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //Username
            Text(
              "$name $lastName",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            //Email
            Text(
              email,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50.0,
                ),
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: const Color(0xffFBC512),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Text(
                      'Editar Perfil',
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
            const Divider(
              height: 20,
              color: Colors.grey,
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
            const Divider(
              height: 30,
              color: Colors.grey,
            ),
            GestureDetector(
              onTap: () async {
                SharedPreferences preferences =
                    await SharedPreferences.getInstance();
                setState(() {
                  preferences.clear();
                });
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: const Color(0xff152534),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.logout_rounded,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        const Text(
                          'Cerrar Sesión',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Icon(Icons.chevron_right_rounded),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
