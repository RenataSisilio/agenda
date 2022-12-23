import 'package:flutter/material.dart';

import '../../../globals.dart';
import '../../../models/mission.dart';
import 'day.dart';

class CalendarMonth extends StatelessWidget {
  const CalendarMonth({
    super.key,
    required this.list,
    required this.allEvents,
  });

  final List<DateTime> list;
  final List<Mission> allEvents;

  @override
  Widget build(BuildContext context) {
    final monthStr = months[list[15].month - 1];
    bool current = false;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppBar(
            automaticallyImplyLeading: false,
            title: Text(monthStr),
            actions: [
              Center(child: Text('${list[15].year}')),
              const SizedBox(
                width: 16.0,
              )
            ],
          ),
          Row(
            children: List.generate(
              7,
              (index) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      MediaQuery.of(context).size.width > 400
                          ? weekdays[index]
                          : weekdays[index][0],
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              ),
            ),
          ),
          GridView.builder(
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
                  color: Colors.blue,
                  currentMonth: current,
                  isToday: list[index] == today,
                  events: allEvents
                      .where(
                          (event) => event.date.isAtSameMomentAs(list[index]))
                      .toList(),
                );
              }),
        ],
      ),
    );
  }
}
