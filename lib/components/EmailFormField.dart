import 'package:flutter/material.dart';

class EmailFormField extends StatelessWidget {
  final String placeholder;
  double padding;
  bool hidetext;
  EmailFormField({
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
              !RegExp(r'^(([^<>()\[\]\\.,;:\s@”]+(\.[^<>()\[\]\\.,;:\s@”]+)*)|(“.+”))@((\[[0–9]{1,3}\.[0–9]{1,3}\.[0–9]{1,3}\.[0–9]{1,3}])|(([a-zA-Z\-0–9]+\.)+[a-zA-Z]{2,}))$')
                  .hasMatch(value)) {
            return "Enter a valid email";
          } else {
            return "Que esta pasando";
          }
        },
      ),
    );
  }
}
