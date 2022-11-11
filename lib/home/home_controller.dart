import 'package:agenda/home/home_repository.dart';

class HomeController {
  final HomeRepository repository;

  HomeController(this.repository);

  Future<bool> getData() async {
    return await repository.getData();
  }

  List<DateTime> rangeDaysList(int year, int month) {
    DateTime first = DateTime(year, month);
    DateTime last = DateTime(year, month, 28);
    List<DateTime> list = [];

    while (first.weekday != DateTime.sunday) {
      first = first.subtract(const Duration(days: 1));
    }
    while (last.month == month) {
      last = last.add(const Duration(days: 1));
    }
    while (last.weekday != DateTime.saturday) {
      last = last.add(const Duration(days: 1));
    }
    for (var day = first;
        day != last.add(const Duration(days: 1));
        day = day.add(const Duration(days: 1))) {
      list.add(day);
    }
    return list;
  }
}
