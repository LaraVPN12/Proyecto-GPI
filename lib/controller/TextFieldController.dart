import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:postgres/postgres.dart';
import 'package:proyecto_visitas/controller/data_controller.dart';
import 'package:proyecto_visitas/screens/User.dart';

class TextFieldController extends GetxController {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController? nameController, emailController, passwordController;
  var name;
  var email = '';
  var password = '';
  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController!.dispose();
    emailController!.dispose();
    passwordController!.dispose();
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (!GetUtils.isEmail(value)) {
      return "Formato de correo incorrecto";
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (!RegExp(r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}')
        .hasMatch(value)) {
      return "Debe contener al menos un número y una mayúscula";
    } else if (GetUtils.isLengthGreaterThan(value, 8)) {
      return "Sobrepasa los 8 dígitos";
    }
    return null;
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (!RegExp(r'^[A-Z].*').hasMatch(value)) {
      return "Debe Contener Inicial Mayúscula";
    } else if (GetUtils.isLengthLessThan(value, 3)) {
      return "Debe contener al menos 3 dígitos";
    }
    return null;
  }

  String? validateLastName(String value) {
    if (value.isEmpty) {
      return "* Required";
    } else if (!RegExp(r'^[A-Z].*').hasMatch(value)) {
      return "Debe Contener Inicial Mayúscula";
    } else if (GetUtils.isLengthLessThan(value, 3)) {
      return "Debe contener al menos 3 dígitos";
    }
    return null;
  }

  void route(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => UserPage(),
    ));
  }

  bool checkLogin(BuildContext context) {
    final isValid = formkey.currentState!.validate();
    if (!isValid) {
      return false;
    }
    formkey.currentState!.save();
    return true;
  }
}
