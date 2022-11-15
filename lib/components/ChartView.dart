import 'package:flutter/material.dart';

class ChartView extends StatelessWidget {
  const ChartView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 4,
      child: LayoutBuilder(
        builder: (context, constraint) => Container(
          decoration: const BoxDecoration(
            color: Color.fromRGBO(193, 214, 233, 1),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  spreadRadius: -10,
                  blurRadius: 17,
                  offset: Offset(-5, -5),
                  color: Colors.white),
              BoxShadow(
                spreadRadius: -2,
                blurRadius: 10,
                offset: Offset(7, 7),
                color: Color.fromRGBO(146, 182, 216, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
