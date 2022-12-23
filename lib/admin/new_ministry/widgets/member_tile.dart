import 'package:flutter/material.dart';

class MemberTile extends StatefulWidget {
  const MemberTile(
    this.name, {
    super.key,
    required this.onChange,
  });

  final String name;
  final Function(bool) onChange;

  @override
  State<MemberTile> createState() => _MemberTileState();
}

class _MemberTileState extends State<MemberTile> {
  final notifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: notifier.value,
          onChanged: (value) {
            setState(() {
              widget.onChange(value!);
              notifier.value = value;
            });
          },
        ),
        Text(widget.name),
      ],
    );
  }
}
