import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:proyecto_visitas/controller/data_controller.dart';
import 'package:proyecto_visitas/screens/Admin.dart';
import '../components/AreaItem.dart';
import '../components/SelectedItem.dart';
import '../controller/TextFieldController.dart';
import '../model/Area.dart';

class MemberForm extends StatefulWidget {
  const MemberForm({super.key});

  @override
  State<MemberForm> createState() => _MemberFormState();
}

class _MemberFormState extends State<MemberForm> {
  List<Area> areaItems = [];
  List<Area> itemsSelected = [];
  TextFieldController controller = TextFieldController();
  DataController dataController = DataController();
  late String primer_nombre,
      segundo_nombre,
      primer_apellido,
      segundo_apellido,
      correo;

  Future getAreas() async {
    final connection = PostgreSQLConnection(
      'proyecto-visitas.cssse3lhtwmj.us-east-2.rds.amazonaws.com',
      5432,
      'proyecto_gpi',
      username: 'kevin_eli',
      password: 'GPIProj3ct.',
    );
    await connection.open();
    var results = await connection
        .query(''' SELECT nombre_area_educativa FROM area_educativa''');
    for (var row in results) {
      setState(() {
        areaItems.add(Area(row[0]));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAreas();
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
                    'Nuevo Miembro',
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
                        labelText: 'Segundo Apellido',
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
                        correo = value!;
                        return controller.validateEmail(value);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: const Text(
                      'Seleccione la/s Área/s Educativa/s pertinentes',
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 50,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              ...List.generate(
                                  areaItems.length,
                                  (index) => Center(
                                        child: AreaItem(
                                          areaItems: areaItems,
                                          onSelected: (bool value) {
                                            if (value) {
                                              itemsSelected
                                                  .add(areaItems[index]);
                                            } else {
                                              itemsSelected
                                                  .remove(areaItems[index]);
                                            }
                                            setState(() {});
                                          },
                                          area: areaItems[index],
                                        ),
                                      ))
                            ],
                          ),
                        ),
                        Container(
                          height: 50,
                          width: double.infinity,
                          child: Wrap(
                            spacing: 10.0,
                            children: [
                              ...List.generate(
                                itemsSelected.length,
                                (index) => SelectedItem(
                                  title: itemsSelected[index].title,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (controller.checkLogin(context)) {
                        dataController.addTecnico(
                          primer_nombre,
                          segundo_nombre,
                          primer_apellido,
                          segundo_apellido,
                          correo,
                        );
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => const AdminPage(),
                          ),
                          (route) => false,
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                        vertical: 20,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: const Color(0xff152534),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            'Agregar Miembro',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
