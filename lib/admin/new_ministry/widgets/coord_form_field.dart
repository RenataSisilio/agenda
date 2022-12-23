import 'package:flutter/material.dart';

class CoordFormField extends StatelessWidget {
  const CoordFormField({
    super.key,
    required this.users,
    required this.controller,
  });

  final Map<String, String>? users;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: const InputDecoration(
        labelText: 'Coordenador(a)',
      ),
      items: users?.entries
          .map((user) => DropdownMenuItem(
                value: user.key,
                child: Text(user.value),
              ))
          .toList(),
      onChanged: (value) {
        controller.text = value!;
      },
      validator: (value) =>
          (value?.isEmpty ?? true) ? 'Campo obrigatório' : null,
    );
  }
}
