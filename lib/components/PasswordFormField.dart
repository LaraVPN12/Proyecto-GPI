import 'package:flutter/material.dart';

class PasswordFormField extends StatelessWidget {
  final String placeholder;
  double padding;
  bool hidetext;
  PasswordFormField({
    required this.placeholder,
    this.padding = 0.0,
    this.hidetext = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: TextFormField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          labelText: placeholder,
        ),
        obscureText: hidetext,
        validator: (value) {
          if (value!.isEmpty ||
              !RegExp(r'(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}')
                  .hasMatch(value!)) {
            return "Enter a valid password";
          } else {
            return null;
          }
        },
      ),
    );
  }
}
