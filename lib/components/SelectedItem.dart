import 'package:flutter/material.dart';

class SelectedItem extends StatelessWidget {
  final String title;
  const SelectedItem({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Color(0xff152534),
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.amber[100],
      padding: const EdgeInsets.all(5),
    );
  }
}
