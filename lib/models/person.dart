import 'package:uuid/uuid.dart';

abstract class Person {
  Person(
    this._name,
    this._ministry, [
    Map<String, dynamic>? settings,
  ]) : _settings = settings ?? {};

  final id = const Uuid();
  final String _name;
  final Map<String, dynamic> _settings;
  final List<String> _ministry;
}

class Member extends Person {
  Member(super.naome, super.ministry, [super.settings]);
}

class Coordinator extends Person {
  Coordinator(super.name, super.ministry, [super.settings]);
}

class Admin extends Person {
  Admin(super.name, super.ministry, [super.settings]);
}
