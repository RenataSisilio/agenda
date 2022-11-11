import 'package:flutter/material.dart';

import '../../globals.dart';
import 'day.dart';

class CalendarMonth extends StatelessWidget {
  const CalendarMonth({
    Key? key,
    required this.list,
  }) : super(key: key);

  final List<DateTime> list;

  @override
  Widget build(BuildContext context) {
    bool current = false;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7, //days per week
            childAspectRatio: 1, //square
            mainAxisSpacing: 4.0,
            crossAxisSpacing: 4.0,
          ),
          itemCount: list.length,
          itemBuilder: (context, index) {
            if (list[index].day == 1) {
              current = !current;
            }
            return Day(
              list[index].day,
              hasEvents: allEvents.any((event) => event.date == list[index]),
              hasParticipation:
                  list[index].day % 5 == 0, //just for layout testing
              color: Colors.blue,
              currentMonth: current,
            );
          }),
    );
  }
}
