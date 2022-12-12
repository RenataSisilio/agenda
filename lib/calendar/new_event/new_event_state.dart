import '../../models/ministry.dart';

abstract class NewEventState {}

class LoadingNewEventState implements NewEventState {}

class SuccessNewEventState implements NewEventState {
  final List<Ministry> userMinistries;

  SuccessNewEventState(this.userMinistries);
}

class ErrorNewEventState implements NewEventState {}
