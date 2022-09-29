import 'package:flutter/material.dart';
import 'CustomTextField.dart';

class RegisterItem extends StatelessWidget {
  final String itemName;
  final CustomTextField textField;
  const RegisterItem({
    Key? key,
    required this.itemName,
    required this.textField,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            itemName,
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(
            height: 10,
          ),
          textField,
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
