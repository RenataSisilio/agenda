import 'package:flutter/material.dart';

class AssigneeTile extends StatefulWidget {
  const AssigneeTile(this.name, {super.key});

  final String name;

  @override
  State<AssigneeTile> createState() => _AssigneeTileState();
}

class _AssigneeTileState extends State<AssigneeTile> {
  bool isAssigned = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isAssigned,
          onChanged: (value) {
            setState(() {
              isAssigned = value ?? false;
            });
          },
        ),
        Text(widget.name),
      ],
    );
  }
}
