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
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Colors.blue.shade100,
      padding: const EdgeInsets.all(5),
    );
  }
}
