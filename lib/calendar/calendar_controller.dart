import 'package:bloc/bloc.dart';

import '../models/mission.dart';
import 'home/home_repository.dart';
import 'home/home_state.dart';

class CalendarController extends Cubit<HomeState> {
  static final _instance = CalendarController._();

  CalendarController._() : super(LoadingHomeState()) {
    getData();
  }

  factory CalendarController.instance() {
    return _instance;
  }

  late final HomeFirestoreRepository firestoreRepo;

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
