import 'package:flutter/material.dart';

class Day extends StatelessWidget {
  const Day(
    this.day, {
    this.hasEvents = false,
    this.hasParticipation = false,
    this.currentMonth = true,
    this.color,
    Key? key,
  })  : assert(!(hasEvents || hasParticipation) || color != null),
        super(key: key);

  final int day;
  final bool hasEvents;
  final bool hasParticipation;
  final Color? color;
  final bool currentMonth;

  @override
  Widget build(BuildContext context) {
    final text = Text('$day');
    return currentMonth
        ? hasEvents
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      side: BorderSide(color: color!)),
                  elevation: 0,
                  backgroundColor: color,
                ),
                onPressed: () {},
                child: text,
              )
            : hasParticipation
                ? OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: color,
                        side: BorderSide(width: 2.0, color: color!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                    onPressed: () {},
                    child: text,
                  )
                : OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black54,
                        side: const BorderSide(
                          width: 2.0,
                          color: Colors.black45,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )),
                    onPressed: () {},
                    child: text,
                  )
        : TextButton(
            style: TextButton.styleFrom(
              foregroundColor: Colors.black45,
            ),
            onPressed: () {},
            child: text,
          );
  }
}
