import 'package:flutter/material.dart';

class ChartCategories extends StatelessWidget {
  const ChartCategories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.greenAccent,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              const Text(
                'Agosto',
              ),
            ],
          )
        ],
      ),
    );
  }
}
