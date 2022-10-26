import 'package:flutter/material.dart';
import '../controller/TextFieldController.dart';

class MemberForm extends StatefulWidget {
  const MemberForm({super.key});

  @override
  State<MemberForm> createState() => _MemberFormState();
}

class _MemberFormState extends State<MemberForm> {
  @override
  void initState() {
    super.initState();
  }

  TextFieldController controller = TextFieldController();
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
                    height: 10,
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
                        labelText: 'Nombre',
                      ),
                      obscureText: false,
                      validator: (value) {
                        return controller.validateName(value!);
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
                        labelText: 'Nombre',
                      ),
                      obscureText: false,
                      validator: (value) {
                        return controller.validateName(value!);
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
                        labelText: 'Apellido',
                      ),
                      obscureText: false,
                      validator: (value) {
                        return controller.validateLastName(value!);
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
                        labelText: 'Apellido',
                      ),
                      obscureText: false,
                      validator: (value) {
                        return controller.validateLastName(value!);
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
                        return controller.validateEmail(value!);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: () {
                      if (controller.checkLogin(context)) {}
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 25.0,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.greenAccent[400],
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
