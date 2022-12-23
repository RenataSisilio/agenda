import 'package:flutter/material.dart';

import '../../../models/ministry.dart';
import '../../calendar_controller.dart';

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
    required this.formKey,
    required this.description,
    required this.ministry,
    required this.date,
    required this.hour,
    required this.local,
    required this.assignees,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController description;
  final ValueNotifier<Ministry?> ministry;
  final TextEditingController date;
  final TextEditingController hour;
  final TextEditingController local;
  final List<ValueNotifier<bool>> assignees;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              if (formKey.currentState?.validate() ?? false) {
                final navigator = Navigator.of(context);
                final scaffoldMessenger = ScaffoldMessenger.of(context);
                if (await CalendarController.instance.addEvent(
                  description: description.text,
                  ministry: ministry.value!,
                  date: date.text,
                  hour: hour.text,
                  local: local.text,
                  assignees: assignees.map((e) => e.value).toList(),
                )) {
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text('${description.text} criado com sucesso!'),
                    ),
                  );
                  if (navigator.canPop()) {
                    navigator.pop();
                  }
                } else {
                  scaffoldMessenger.showSnackBar(
                    const SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text('Algo deu errado. Tente novamente.'),
                    ),
                  );
                }
              }
            },
            child: const Text('SALVAR'),
          ),
        ),
      ],
    );
  }
}
