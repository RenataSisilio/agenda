import 'package:uuid/uuid.dart';

class Mission {
  Mission({
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

  DateTime get dateTime => _dateTime;
  DateTime get date => DateTime(_dateTime.year, _dateTime.month, _dateTime.day);

  Mission copyWith({
    List<Uuid>? missionaries,
    String? ministry,
    DateTime? dateTime,
    String? local,
  }) {
    return Mission(
      missionaries: missionaries ?? _idMissionariesList,
      ministry: ministry ?? _ministry,
      dateTime: dateTime ?? _dateTime,
      local: local ?? _local,
    );
  }
}
