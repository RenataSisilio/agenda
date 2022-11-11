import 'package:agenda/home/home_repository.dart';

import '../globals.dart';

class HomeController {
  HomeController(this.repository);

  final HomeRepository repository;
  DateTime _date = today;

  Future<bool> getData() async {
    return await repository.getData();
  }

  DateTime get date => _date;

  void setDate(DateTime newDate) => _date = newDate;

  List<DateTime> rangeDaysList() {
    const aDay = Duration(days: 1);
    int year = _date.year;
    int month = _date.month;
    DateTime first = DateTime(year, month);
    DateTime last = DateTime(year, month, 28);
    List<DateTime> list = [];

    while (first.weekday != DateTime.sunday) {
      first = first.subtract(aDay);
    }
    while (last.add(aDay).month == month) {
      last = last.add(aDay);
    }
    while (last.weekday != DateTime.saturday) {
      last = last.add(aDay);
    }
    for (var day = first; day != last.add(aDay); day = day.add(aDay)) {
      list.add(day);
    }
    return list;
  }
}
