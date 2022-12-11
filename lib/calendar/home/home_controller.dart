import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../globals.dart';
import 'home_repository.dart';
import 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  HomeController() : super(LoadingHomeState()) {
    getData();
  }

  late final HomeFirestoreRepository firestoreRepo;
  DateTime _date = today;

  void getData() async {
    emit(LoadingHomeState());
    firestoreRepo = HomeFirestoreRepository();
    try {
      final missions = await firestoreRepo.getMissionsByMinistry('test-ministry-id');
      emit(SuccessHomeState(missions));
    } catch (e) {
      emit(ErrorHomeState());
    }
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

  void addEvent(String description, DateTime date) async {
    final firestore = FirebaseFirestore.instance;
    final userName = FirebaseAuth.instance.currentUser!.displayName;
    emit(LoadingHomeState());
    await firestore.collection('$userName Events').add(<String, dynamic>{
      'text': description,
      'timestamp': date,
    }).then(
      (_) => getData(),
      onError: (_) => emit(ErrorHomeState()),
    );
  }
}
