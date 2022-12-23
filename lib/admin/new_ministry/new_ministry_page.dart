import 'package:flutter/material.dart';

class NewMinistryPage extends StatefulWidget {
  const NewMinistryPage({super.key});

  @override
  State<NewMinistryPage> createState() => _NewMinistryPageState();
}

class _NewMinistryPageState extends State<NewMinistryPage> {
  final name = TextEditingController();
  final coord = TextEditingController();
  final members = <String>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        child: Column(
          children: [
            TextFormField(
              controller: name,
              decoration: const InputDecoration(
                label: Text('Nome'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
