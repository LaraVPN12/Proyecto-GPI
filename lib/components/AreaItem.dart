import 'package:flutter/material.dart';

import '../model/Area.dart';

class AreaItem extends StatefulWidget {
  final Area area;
  final ValueChanged<bool> onSelected;
  const AreaItem({
    Key? key,
    required this.areaItems,
    required this.area,
    required this.onSelected,
  }) : super(key: key);

  final List<Area> areaItems;

  @override
  State<AreaItem> createState() => _AreaItemState();
}

class _AreaItemState extends State<AreaItem> {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          widget.onSelected(_isSelected);
        });
      },
      child: AnimatedContainer(
        duration: const Duration(
          milliseconds: 200,
        ),
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        decoration: BoxDecoration(
          color: _isSelected ? null : Colors.grey.shade300,
          shape: BoxShape.rectangle,
          border: _isSelected
              ? Border.all(
                  width: 2.0,
                  color: Colors.greenAccent.shade400,
                )
              : null,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          widget.area.title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
