import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/ministry.dart';
import 'new_event_controller.dart';
import 'new_event_state.dart';
import 'widgets/assignee_tile.dart';
import 'widgets/date_picker_form_field.dart';
import 'widgets/ministry_form_field.dart';
import 'widgets/save_button.dart';

class NewEventPage extends StatefulWidget {
  const NewEventPage({super.key});

  @override
  State<NewEventPage> createState() => _NewEventPageState();
}

class _NewEventPageState extends State<NewEventPage> {
  final formKey = GlobalKey<FormState>();
  final description = TextEditingController();
  final date = TextEditingController();
  final ministry = ValueNotifier<Ministry?>(null);
  final local = TextEditingController();

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
                BlocBuilder<NewEventController, NewEventState>(
                  bloc: NewEventController(),
                  builder: (context, state) {
                    return MinistryFormField(
                        ministries: state is SuccessNewEventState
                            ? state.userMinistries
                            : null,
                        controller: ministry);
                  },
                ),
                DatePickerFormField(date),
                TextFormField(
                  controller: local,
                  decoration: const InputDecoration(
                    label: Text('Local'),
                    prefixIcon: Icon(Icons.location_pin),
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: ministry,
                  builder: (_, value, __) {
                    return value != null
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: value.members.length,
                            itemBuilder: (context, index) {
                              return AssigneeTile(value.members[index]);
                            },
                          )
                        : const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 20),
                SaveButton(
                  formKey: formKey,
                  description: description.text,
                  ministry: ministry.value?.id ?? 'unregistered',
                  date: date.text,
                  hour: '',
                  local: local.text,
                  idMissionariesList: [],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

