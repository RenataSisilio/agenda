import 'package:cloud_firestore/cloud_firestore.dart';

class Mission {
  Mission(
    this.description, {
    this.id,
    required this.ministry,
    required this.dateTime,
    required this.idMissionariesList,
    required this.local,
  });

  final String? id;
  final List<String> idMissionariesList;
  final String ministry;
  final DateTime dateTime;
  final String local;
  final String description;

  DateTime get date => DateTime(dateTime.year, dateTime.month, dateTime.day);

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({
      'idMissionariesList': idMissionariesList,
      'date': Timestamp.fromDate(dateTime),
      'local': local,
      'name': description,
    });

    return result;
  }

  factory Mission.fromMap(Map<String, dynamic> map,
      {required String id, required String ministryId}) {
    return Mission(
      map['name'] ?? '',
      id: id,
      ministry: ministryId,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['date'].millisecondsSinceEpoch),
      local: map['local'] ?? '',
      idMissionariesList: List<String>.from(map['idMissionariesList']),
    );
  }

  Mission copyWith({
    List<String>? idMissionariesList,
    String? ministry,
    DateTime? dateTime,
    String? local,
    String? description,
  }) {
    return Mission(
      description ?? this.description,
      id: id,
      ministry: ministry ?? this.ministry,
      dateTime: dateTime ?? this.dateTime,
      local: local ?? this.local,
      idMissionariesList: idMissionariesList ?? this.idMissionariesList,
    );
  }
}
