import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/ministry_repository.dart';
import 'new_ministry_controller.dart';
import 'new_ministry_states.dart';
import 'widgets/coord_form_field.dart';
import 'widgets/member_tile.dart';

class NewMinistryPage extends StatefulWidget {
  const NewMinistryPage({super.key});

  @override
  State<NewMinistryPage> createState() => _NewMinistryPageState();
}

class _NewMinistryPageState extends State<NewMinistryPage> {
  final controller = NewMinistryController(MinistryFirestoreRepository());

  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final coord = TextEditingController();
  final ministryMembers = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Ministério'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              TextFormField(
                controller: name,
                decoration: const InputDecoration(
                  label: Text('Ministério'),
                ),
                validator: (value) =>
                    (value?.isEmpty ?? true) ? 'Campo obrigatório' : null,
              ),
              FutureBuilder(
                future: controller.getAllUserNames(),
                builder: (context, snapshot) {
                  final memberNames = [];
                  final memberIds = [];
                  if (snapshot.hasData && !snapshot.hasError) {
                    memberNames.addAll(snapshot.data!.values);
                    memberIds.addAll(snapshot.data!.keys);
                  }
                  return Column(
                    children: [
                      CoordFormField(users: snapshot.data, controller: coord),
                      snapshot.hasData
                          ? ListView.builder(
                              shrinkWrap: true,
                              itemCount: memberNames.length,
                              itemBuilder: (context, index) {
                                return MemberTile(
                                  memberNames[index]!,
                                  onChange: (selected) {
                                    if (selected) {
                                      ministryMembers.add(memberIds[index]);
                                    } else {
                                      ministryMembers.remove(memberIds[index]);
                                    }
                                  },
                                );
                              },
                            )
                          : const SizedBox.shrink(),
                      BlocConsumer(
                        bloc: controller,
                        listener: (context, state) {
                          if (state is SuccessNewMinistryState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content:
                                    Text('${name.text} criado com sucesso!'),
                              ),
                            );
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/admin', (route) => false);
                          }
                          if (state is ErrorNewMinistryState) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                behavior: SnackBarBehavior.floating,
                                content:
                                    Text('Algo deu errado. Tente novamente.'),
                              ),
                            );
                          }
                        },
                        builder: (context, state) => state ==
                                LoadingNewMinistryState
                            ? const CircularProgressIndicator()
                            : Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (formKey.currentState?.validate() ??
                                            false) {
                                          controller.saveMinistry(name.text,
                                              coord.text, ministryMembers);
                                        }
                                      },
                                      child: const Text('SALVAR'),
                                    ),
                                  ),
                                ],
                              ),
                      )
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
