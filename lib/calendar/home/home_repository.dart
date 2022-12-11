import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/ministry.dart';
import '../../models/mission.dart';
import '../../paths.dart';

abstract class HomeRepository {
  Future<List<Mission>> getMissionsByMinistry(String ministryId);
  Future<List<Mission>> getMissionsByUser(String userId);
  Future<bool> saveMission(Mission mission);
  Future<bool> editMission(Mission mission);
  Future<bool> deleteMission(String missionId);

  Future<List<Ministry>> getMinistries(String userId);
  Future<bool> saveMinistry(Ministry ministry);
  Future<bool> editMinistry(Ministry ministry);
  Future<bool> deleteMinistry(String ministryId);
}

class HomeFirestoreRepository implements HomeRepository {
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
  Future<List<Mission>> getMissionsByUser(userId) {
    // TODO: implement getMissionsByUser
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteMinistry(String ministryId) {
    // TODO: implement deleteMinistry
    throw UnimplementedError();
  }

  @override
  Future<bool> deleteMission(String missionId) {
    // TODO: implement deleteMission
    throw UnimplementedError();
  }

  @override
  Future<bool> editMinistry(Ministry ministry) {
    // TODO: implement editMinistry
    throw UnimplementedError();
  }

  @override
  Future<bool> editMission(Mission mission) {
    // TODO: implement editMission
    throw UnimplementedError();
  }

  @override
  Future<List<Ministry>> getMinistries(String userId) {
    // TODO: implement getMinistries
    throw UnimplementedError();
  }

  @override
  Future<bool> saveMinistry(Ministry ministry) {
    // TODO: implement saveMinistry
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
