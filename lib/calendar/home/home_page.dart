import 'package:agenda/calendar/home/home_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../globals.dart';
import 'widgets/app_drawer.dart';
import 'widgets/calendar_month.dart';
import 'widgets/legend_fab.dart';
import '../home_controller.dart';
import 'home_repository.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController(HomeRepository());

  @override
  Widget build(BuildContext context) {
    final pageController =
        PageController(initialPage: today.month + 11); //index of current month
    return Scaffold(
      appBar: AppBar(
        title: Text(FirebaseAuth.instance.currentUser!.displayName!),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: Center(
        child: BlocBuilder<HomeController, HomeState>(
          bloc: controller,
          builder: (context, state) {
            if (state is SuccessHomeState) {
              return PageView.builder(
                controller: pageController,
                itemCount: 36,
                itemBuilder: (context, index) {
                  controller.setDate(
                    index < 12 // previous year
                        ? DateTime(today.year - 1, index + 1)
                        : index < 24 // current year
                            ? DateTime(today.year, index - 12 + 1)
                            : DateTime(
                                // next year
                                today.year + 1,
                                index - 24 + 1),
                  );
                  return Center(
                    child: SingleChildScrollView(
                      child: CalendarMonth(list: controller.rangeDaysList()),
                    ),
                  );
                },
              );
            }
            if (state is ErrorHomeState) {
              return const Text('Erro');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: const LegendFAB(),
    );
  }
}
