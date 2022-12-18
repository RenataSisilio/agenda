import '../../models/ministry.dart';

abstract class MinistryListState {}

class LoadingMinistryListState implements MinistryListState {}

class SuccessMinistryListState implements MinistryListState {
  final List<Ministry> ministries;

  SuccessMinistryListState(this.ministries);
}

class ErrorMinistryListState implements MinistryListState {}
