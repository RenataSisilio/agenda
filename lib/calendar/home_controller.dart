import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../globals.dart';
import 'home/home_repository.dart';
import 'home/home_state.dart';

class HomeController extends Cubit<HomeState> {
  HomeController(this.repository) : super(LoadingHomeState());

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

  Future<DocumentReference> addEvent(String description, DateTime date) {
    final firestore = FirebaseFirestore.instance;
    final userName = FirebaseAuth.instance.currentUser!.displayName;
    return firestore.collection('$userName Events').add(<String, dynamic>{
      'text': description,
      'timestamp': date,
    });
  }
}
