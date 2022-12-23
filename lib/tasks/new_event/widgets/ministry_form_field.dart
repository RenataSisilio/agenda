import 'package:flutter/material.dart';

import '../../../models/ministry.dart';

class MinistryFormField extends StatelessWidget {
  const MinistryFormField({
    Key? key,
    required this.ministries,
    required this.controller,
    required this.assignList,
  }) : super(key: key);

  final List<Ministry>? ministries;
  final ValueNotifier<Ministry?> controller;
  final List<ValueNotifier<bool>> assignList;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: 'Ministério',
      ),
      items: ministries
          ?.map((ministry) => DropdownMenuItem(
                value: ministry,
                child: Text(ministry.name),
              ))
          .toList(),
      onChanged: (value) {
        controller.value = value!;
        for (var element in assignList) {
          element.value = false;
        }
      },
    );
  }
}
