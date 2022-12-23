import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/ministry_repository.dart';
import 'ministry_list_states.dart';
import 'ministry_list_controller.dart';

class MinistryListPage extends StatefulWidget {
  const MinistryListPage({super.key});

  @override
  State<MinistryListPage> createState() => _MinistryListPageState();
}

class _MinistryListPageState extends State<MinistryListPage> {
  final controller = MinistryListController(MinistryFirestoreRepository());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ministérios'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed('/new-ministry'),
        tooltip: 'Novo',
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<MinistryListController, MinistryListState>(
        bloc: controller,
        builder: (context, state) {
          if (state is ErrorMinistryListState) {
            return const Center(
              child: Text('Erro ao carregar os dados'),
            );
          }
          if (state is SuccessMinistryListState) {
            return ListView.builder(
              itemCount: state.ministries.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  state.ministries[index].name,
                ),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
