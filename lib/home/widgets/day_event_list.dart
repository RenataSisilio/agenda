import 'package:flutter/material.dart';

import '../../globals.dart';
import '../../models/mission.dart';

class DayEventList extends StatelessWidget {
  const DayEventList({
    Key? key,
    required this.events,
    required this.color,
  }) : super(key: key);

  final List<Mission> events;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) => ListTile(
          minLeadingWidth: 16,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 16.0,
              width: 16.0,
              decoration: ShapeDecoration(
                color: color.withOpacity(
                    events[index].idMissionariesList.contains(user.id) ? 1 : 0),
                shape: CircleBorder(
                  side: BorderSide(width: 2.0, color: color),
                ),
              ),
            ),
          ),
          title: Text(events[index].description),
          subtitle: Text(
              TimeOfDay.fromDateTime(events[index].dateTime).format(context)),
        ),
      ),
    );
  }
}
