import 'package:flutter/material.dart';

import 'components/calendar_month.dart';
import 'components/legend_fab.dart';
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
    final pageController = PageController(initialPage: controller.date.month);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
          ),
        ),
        title: const Text('Nome'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Center(
        child: FutureBuilder(
            future: controller.getData(),
            builder: (context, snapshot) {
              if (snapshot.hasData && !snapshot.hasError) {
                return PageView(
                  controller: pageController,
                  children: List.generate(12, (index) {
                    controller.setDate(DateTime(2022, index + 1));
                    return CalendarMonth(list: controller.rangeDaysList());
                  }),
                );
              }
              if (snapshot.hasError) {
                return const Text(
                  'Error',
                );
              }
              return const CircularProgressIndicator();
            }),
      ),
      floatingActionButton: const LegendFAB(),
    );
  }
}
