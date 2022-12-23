import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/mission.dart';
import '../paths.dart';
import '../shared/ministry_repository.dart';

abstract class CalendarRepository {
  Future<List<Mission>> getMissionsByMinistry(String ministryId);
  Future<List<Mission>> getMissionsByUser(String userId);
  Future<bool> saveMission(Mission mission);
  Future<bool> editMission(Mission mission);
  Future<bool> deleteMission(String missionId);
}

class CalendarFirestoreRepository implements CalendarRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<List<Mission>> getMissionsByMinistry(String ministryId) async {
    final missions = <Mission>[];
    final querySnapshot = await firestore
        .collection(Paths.ministryCollection)
        .doc(ministryId)
        .collection(Paths.missionCollection)
        .get();
    for (var mission in querySnapshot.docs) {
      missions.add(
        Mission.fromMap(
          mission.data(),
          id: mission.id,
          ministryId: ministryId,
        ),
      );
    }

    return missions;
  }

  @override
  Future<List<Mission>> getMissionsByUser(userId) async {
    final ministries =
        await MinistryFirestoreRepository().getMinistries(userId);
    final missions = <Mission>[];
    for (var ministry in ministries) {
      missions.addAll(await getMissionsByMinistry(ministry.id!));
    }
    return missions;
  }

  @override
  Future<bool> deleteMission(String missionId) {
    // TODO: implement deleteMission
    throw UnimplementedError();
  }

  @override
  Future<bool> editMission(Mission mission) {
    // TODO: implement editMission
    throw UnimplementedError();
  }

  @override
  Future<bool> saveMission(Mission mission) async {
    try {
      await firestore
          .collection(Paths.ministryCollection)
          .doc(mission.ministry)
          .collection(Paths.missionCollection)
          .add(mission.toMap());
      return true;
    } catch (e) {
      return false;
    }
  }
}
