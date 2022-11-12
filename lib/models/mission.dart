import 'package:uuid/uuid.dart';

class Mission {
  Mission(
    this._description, {
    required String ministry,
    required DateTime dateTime,
    required List<Uuid> missionaries,
    String local = '',
  })  : _ministry = ministry,
        _dateTime = dateTime,
        _idMissionariesList = missionaries,
        _local = local;

  final id = const Uuid();
  final List<Uuid> _idMissionariesList;
  final String _ministry;
  final DateTime _dateTime;
  final String _local;
  final String _description;

  DateTime get dateTime => _dateTime;
  DateTime get date => DateTime(_dateTime.year, _dateTime.month, _dateTime.day);
  String get ministry => _ministry;
  String get local => _local;
  String get description => _description;
  List<Uuid> get idMissionariesList => _idMissionariesList;

  Mission copyWith(
    String? description, {
    List<Uuid>? missionaries,
    String? ministry,
    DateTime? dateTime,
    String? local,
  }) {
    return Mission(
      description ?? _description,
      missionaries: missionaries ?? _idMissionariesList,
      ministry: ministry ?? _ministry,
      dateTime: dateTime ?? _dateTime,
      local: local ?? _local,
    );
  }
}
