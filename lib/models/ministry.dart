class Ministry {
  Ministry(
    this.name, {
    this.id,
    required this.coord,
    required this.members,
  });

  final String? id;
  final String name;
  final String coord;
  final List<String> members;

  void addMember(String id) {
    if (!members.contains(id)) {
      members.add(id);
    }
  }

  void removeMember(String id) {
    members.remove(id);
  }

  Ministry copyWith({
    String? name,
    String? coord,
  }) {
    final newMinistry = Ministry(
      id: id,
      name ?? this.name,
      coord: coord ?? this.coord,
      members: members,
    );
    return newMinistry;
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'coord': coord});
    result.addAll({'members': members});

    return result;
  }

  factory Ministry.fromMap(Map<String, dynamic> map, {required String id}) {
    return Ministry(
      map['name'] ?? '',
      id: id,
      coord: map['coord'] ?? '',
      members: List.from(map['members']),
    );
  }
}
