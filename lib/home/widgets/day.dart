import 'package:flutter/material.dart';

import '../../globals.dart';
import '../../models/mission.dart';
import 'bottom_sheet.dart';
import 'day_event_list.dart';

class Day extends StatelessWidget {
  const Day(
    this.day, {
    this.currentMonth = true,
    this.color,
    this.isToday = false,
    this.events,
    Key? key,
  })  : assert(!((events?.length ?? 0) > 0) || color != null),
        super(key: key);

  final int day;
  final Color? color;
  final bool currentMonth;
  final bool isToday;
  final List<Mission>? events;

  @override
  Widget build(BuildContext context) {
    final text = Text('$day');
    return currentMonth
        ? (events?.length ?? 0) > 0
            ? events!.any((event) => event.idMissionariesList.contains(user.id))
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      shape: isToday
                          ? CircleBorder(side: BorderSide(color: color!))
                          : RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: BorderSide(color: color!)),
                      elevation: 0,
                      backgroundColor: color,
                    ),
                    onPressed: () => bottomSheet(
                      context: context,
                      child: DayEventList(events: events!, color: color!),
                    ),
                    child: text,
                  )
                : OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      foregroundColor: color,
                      side: BorderSide(width: 2.0, color: color!),
                      shape: isToday
                          ? const CircleBorder()
                          : RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                    ),
                    onPressed: () => bottomSheet(
                      context: context,
                      child: DayEventList(events: events!, color: color!),
                    ),
                    child: text,
                  )
            : OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.all(0),
                  foregroundColor: Colors.black54,
                  side: const BorderSide(
                    width: 2.0,
                    color: Colors.black45,
                  ),
                  shape: isToday
                      ? const CircleBorder()
                      : RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                ),
                onPressed: null,
                child: text,
              )
        : TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(0),
              foregroundColor: Colors.black45,
            ),
            onPressed: null,
            child: text,
          );
  }
}

