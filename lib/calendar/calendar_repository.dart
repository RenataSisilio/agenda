import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/ministry.dart';
import '../models/mission.dart';
import '../paths.dart';

abstract class CalendarRepository {
  Future<List<Mission>> getMissionsByMinistry(String ministryId);
  Future<List<Mission>> getMissionsByUser(String userId);
  Future<bool> saveMission(Mission mission);
  Future<bool> editMission(Mission mission);
  Future<bool> deleteMission(String missionId);

  Future<List<Ministry>> getMinistries(
    String userId, {
    bool coord = false,
  });
  Future<bool> saveMinistry(Ministry ministry);
  Future<bool> editMinistry(Ministry ministry);
  Future<bool> deleteMinistry(String ministryId);

  Future<Map<String, String>> getUserNames();
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
  Future<List<Ministry>> getMinistries(
    String userId, {
    bool coord = false,
  }) async {
    final ministries = <Ministry>[];
    final QuerySnapshot<Map<String, dynamic>> querySnapshot;

    if (coord) {
      querySnapshot = await firestore
          .collection(Paths.ministryCollection)
          .where('coord', isEqualTo: userId)
          .get();
    } else {
      querySnapshot = await firestore
          .collection(Paths.ministryCollection)
          .where('members', arrayContains: userId)
          .get();
    }

    for (var ministry in querySnapshot.docs) {
      ministries.add(
        Ministry.fromMap(
          ministry.data(),
          id: ministry.id,
        ),
      );
    }

    return ministries;
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

  @override
  Future<Map<String, String>> getUserNames() async {
    final missions = <String, String>{};
    final querySnapshot =
        await firestore.collection(Paths.userCollection).get();
    for (var user in querySnapshot.docs) {
      final data = user.data();
      missions[user.id] = data['name'];
    }

    return missions;
  }
}
