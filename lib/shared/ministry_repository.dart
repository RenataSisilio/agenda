import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/ministry.dart';
import '../paths.dart';

abstract class MinistryRepository {
  Future<List<Ministry>> getMinistries(
    String userId, {
    bool coord = false,
  });
  Future<bool> saveMinistry(Ministry ministry);
  Future<bool> editMinistry(Ministry ministry);
  Future<bool> deleteMinistry(String ministryId);
  
  Future<Map<String, String>> getUserNames();
}

class MinistryFirestoreRepository implements MinistryRepository {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<bool> deleteMinistry(String ministryId) {
    // TODO: implement deleteMinistry
    throw UnimplementedError();
  }

  @override
  Future<bool> editMinistry(Ministry ministry) {
    // TODO: implement editMinistry
    throw UnimplementedError();
  }

  @override
  Future<List<Ministry>> getMinistries(
    String userId, {
    bool coord = false,
  }) async {
    final ministries = <Ministry>[];
    final QuerySnapshot<Map<String, dynamic>> querySnap;

    if (coord) {
      querySnap = await firestore
          .collection(Paths.ministryCollection)
          .where('coord', isEqualTo: userId)
          .get();
    } else {
      querySnap = await firestore
          .collection(Paths.ministryCollection)
          .where('members', arrayContains: userId)
          .get();
    }

    for (var ministry in querySnap.docs) {
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
