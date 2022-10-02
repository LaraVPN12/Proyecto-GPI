import 'package:flutter/material.dart';
import 'package:proyecto_visitas/screens/Register.dart';
import '../components/CustomButtom.dart';
import '../components/CustomTextField.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Bienvenido!',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              CustomTextField(
                placeholder: 'Email',
                padding: 25.0,
                hidetext: false,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextField(
                placeholder: 'Contraseña',
                padding: 25.0,
                hidetext: true,
              ),
              const SizedBox(
                height: 25,
              ),
              const CustomButtom(
                text: 'Iniciar Sesión',
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '¿No tiene una cuenta? ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => Register(),
                      ),
                    ),
                    child: Text(
                      'Crea una ahora',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
