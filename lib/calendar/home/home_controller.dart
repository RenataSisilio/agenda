import 'package:agenda/models/mission.dart';
import 'package:bloc/bloc.dart';

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
      final missions =
          await firestoreRepo.getMissionsByMinistry('test-ministry-id');
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

  Future<bool> addEvent(String description, DateTime date) async {
    emit(LoadingHomeState());
    final bool success;
    try {
      success = await firestoreRepo.saveMission(
        Mission(description,
            ministry: 'ministryId',
            dateTime: date,
            idMissionariesList: ['testUserId'],
            local: 'local'),
      );
      getData();
    } catch (e) {
      return false;
    }
    return success;
  }
}
