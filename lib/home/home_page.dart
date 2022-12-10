import 'package:flutter/material.dart';

import '../globals.dart';
import 'widgets/calendar_month.dart';
import 'widgets/legend_fab.dart';
import 'home_controller.dart';
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
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        title: const Text('Nome'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Center(
        child: FutureBuilder(
            future: controller.getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData && !snapshot.hasError) {
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
              if (snapshot.hasError) {
                return const Text(
                  'Erro',
                );
              }
              return const CircularProgressIndicator();
            }),
      ),
      floatingActionButton: const LegendFAB(),
    );
  }
}
