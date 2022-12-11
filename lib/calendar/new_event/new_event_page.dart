import 'package:flutter/material.dart';

import '../home/home_repository.dart';
import '../home/home_controller.dart';
import 'widgets/date_picker_form_field.dart';

class NewEventPage extends StatefulWidget {
  const NewEventPage({super.key});

  @override
  State<NewEventPage> createState() => _NewEventPageState();
}

class _NewEventPageState extends State<NewEventPage> {
  final formKey = GlobalKey<FormState>();
  final description = TextEditingController();
  final date = TextEditingController();

  final controller = HomeController(HomeRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo evento'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: description,
                  decoration: const InputDecoration(
                    label: Text('Título'),
                  ),
                  validator: (value) =>
                      (value?.isEmpty ?? true) ? 'Campo obrigatório' : null,
                ),
                DatePickerFormField(date),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState?.validate() ?? false) {
                            final navigator = Navigator.of(context);
                            final dateAsList = date.text
                                .split('/')
                                .map((e) => int.parse(e))
                                .toList();
                            final formattedDate = DateTime(
                                dateAsList[2], dateAsList[1], dateAsList[0]);
                            controller.addEvent(description.text, formattedDate);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                    '${description.text} criado com sucesso!'),
                              ),
                            );
                            if (navigator.canPop()) {
                              navigator.pop();
                            }
                          }
                        },
                        child: const Text('OK'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
