import 'package:flutter/material.dart';

class AssigneeTile extends StatefulWidget {
  const AssigneeTile(
    this.name, {
    super.key,
    required this.isAssigned,
  });

  final String name;
  final ValueNotifier<bool> isAssigned;

  @override
  State<AssigneeTile> createState() => _AssigneeTileState();
}

class _AssigneeTileState extends State<AssigneeTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.isAssigned.value,
          onChanged: (value) {
            setState(() {
              widget.isAssigned.value = value ?? false;
            });
          },
        ),
        Text(widget.name),
      ],
    );
  }
}
