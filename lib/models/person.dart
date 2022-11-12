import 'package:uuid/uuid.dart';

abstract class Person {
  Person(
    this._name,
    this._ministry,
  );

  final id = const Uuid();
  final String _name;
  final List<String> _ministry;

  String get name => _name;
  List<String> get ministry => _ministry;
}

class Member extends Person {
  Member(super.name, super.ministry);
}

class Coordinator extends Person {
  Coordinator(super.name, super.ministry);
}

class Admin extends Person {
  Admin(super.name, super.ministry);
}
