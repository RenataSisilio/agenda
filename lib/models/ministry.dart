import 'package:uuid/uuid.dart';

class Ministry {
  Ministry(
    this._name, {
    required Uuid coord,
  }) : _coord = coord;

  final String _name;
  final Uuid _coord;
  final List<Uuid> _members = [];
  final List<Uuid> _missions = [];

  String get name => _name;
  Uuid get coord => _coord;
  List<Uuid> get members => _members;
  List<Uuid> get missions => _missions;

  void addMember(Uuid id) {
    if (!_members.contains(id)) {
      _members.add(id);
    }
  }

  void removeMember(Uuid id) {
    _members.remove(id);
  }

  void addMission(Uuid id) {
    if (!_missions.contains(id)) {
      _missions.add(id);
    }
  }

  void removeMission(Uuid id) {
    _missions.remove(id);
  }

  Ministry copyWith({
    String? name,
    Uuid? coord,
  }) {
    final newMinistry = Ministry(
      name ?? _name,
      coord: coord ?? _coord,
    );
    newMinistry._members.addAll(_members);
    newMinistry._missions.addAll(_missions);
    return newMinistry;
  }
}
