import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String placeholder;
  double padding;
  bool hidetext;
  CustomTextField({
    required this.placeholder,
    this.padding = 0.0,
    this.hidetext = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100]?.withOpacity(0.5),
          border: Border.all(
            width: 2.0,
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: TextField(
            obscureText: hidetext,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: placeholder,
            ),
          ),
        ),
      ),
    );
  }
}
