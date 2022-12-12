import 'package:bloc/bloc.dart';

import '../models/ministry.dart';
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
    required Ministry? ministry,
    required String date,
    required String hour,
    required String local,
    required List<bool> assignees,
  }) async {
    final savedMissions = (state as SuccessHomeState).userMissions;
    emit(LoadingHomeState());

    final ministryId = ministry?.id ?? 'unregistered';
    final dateAsList = date.split('/').map((e) => int.parse(e)).toList();
    final formattedDate = DateTime(dateAsList[2], dateAsList[1], dateAsList[0]);
    final idMissionariesList = <String>[];

    final bool success;
    try {
      for (var i = 0; i < assignees.length; i++) {
        if (assignees[i]) {
          idMissionariesList.add(ministry!.members[i]);
        }
      }
      final newMission = Mission(description,
          ministry: ministryId,
          dateTime: formattedDate,
          idMissionariesList: idMissionariesList,
          local: local);
      success = await firestoreRepo.saveMission(newMission);
      savedMissions.add(newMission);
      emit(SuccessHomeState(savedMissions));
    } catch (e) {
      return false;
    }
    return success;
  }
}
