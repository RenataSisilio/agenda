import 'package:flutter/material.dart';

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
    required this.idMissionariesList,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final String description;
  final String ministry;
  final String date;
  final String hour;
  final String local;
  final List<String> idMissionariesList;

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
                  description: description,
                  ministryId: ministry,
                  date: date,
                  hour: hour,
                  local: local,
                  idMissionariesList: [],
                )) {
                  scaffoldMessenger.showSnackBar(
                    SnackBar(
                      behavior: SnackBarBehavior.floating,
                      content: Text('$description criado com sucesso!'),
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
