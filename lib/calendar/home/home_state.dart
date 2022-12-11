import 'package:agenda/models/mission.dart';

abstract class HomeState {}

class LoadingHomeState implements HomeState {}

class SuccessHomeState implements HomeState {
  final List<Mission> userMissions;

  SuccessHomeState(this.userMissions);
}

class ErrorHomeState implements HomeState {}
