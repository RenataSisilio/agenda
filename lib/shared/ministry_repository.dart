import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/ministry.dart';
import '../paths.dart';

abstract class MinistryRepository {
  Future<List<Ministry>> getMinistries(
    String userId, {
    bool coord = false,
  });
  Future<List<Ministry>> getAllMinistries();
  Future<void> saveMinistry(Ministry ministry);
  Future<void> deleteMinistry(String ministryId);

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
  Future<void> saveMinistry(Ministry ministry) async {
    try {
      await firestore
          .collection(Paths.ministryCollection)
          .doc(ministry.id)
          .set(ministry.toMap());
    } catch (e) {
      rethrow;
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

  @override
  Future<List<Ministry>> getAllMinistries() async {
    final ministries = <Ministry>[];
    final querySnap =
        await firestore.collection(Paths.ministryCollection).get();

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
}
