import 'package:bloc/bloc.dart';

import '../models/mission.dart';
import 'home/home_repository.dart';
import 'home/home_state.dart';

class CalendarController extends Cubit<HomeState> {
  static final instance = CalendarController._();

  CalendarController._() : super(LoadingHomeState()) {
    getData();
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

  Future<bool> addEvent({
    required String description,
    required String ministryId,
    required String date,
    required String hour,
    required String local,
    required List<String> idMissionariesList,
  }) async {
    emit(LoadingHomeState());
    
    final dateAsList = date.split('/').map((e) => int.parse(e)).toList();
    final formattedDate = DateTime(dateAsList[2], dateAsList[1], dateAsList[0]);

    final bool success;
    try {
      success = await firestoreRepo.saveMission(
        Mission(description,
            ministry: ministryId,
            dateTime: formattedDate,
            idMissionariesList: idMissionariesList,
            local: local),
      );
      getData();
    } catch (e) {
      return false;
    }
    return success;
  }
}
