import 'package:flutter/material.dart';

class LegendFAB extends StatelessWidget {
  const LegendFAB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: const CircleBorder(
          side: BorderSide(
        color: Colors.black54,
        width: 4.0,
      )),
      backgroundColor: const Color(0x00000000),
      foregroundColor: Colors.black54,
      mini: true,
      elevation: 0,
      hoverElevation: 0,
      hoverColor: const Color(0x00000000),
      onPressed: () {},
      tooltip: 'Legenda',
      child: const Icon(
        Icons.question_mark_rounded,
      ),
    );
  }
}
