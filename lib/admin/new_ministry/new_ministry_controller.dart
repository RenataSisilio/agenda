import 'package:bloc/bloc.dart';

import '../../models/ministry.dart';
import '../../shared/ministry_repository.dart';
import 'new_ministry_states.dart';

class NewMinistryController extends Cubit<NewMinistryState> {
  NewMinistryController(this.repository) : super(InitialNewMinistryState());

  final MinistryRepository repository;

  Future<Map<String, String>> getAllUserNames() async {
    return await repository.getUserNames();
  }

  void saveMinistry(String name, String coord, List<String> members) async {
    emit(LoadingNewMinistryState());
    try {
      await repository
          .saveMinistry(Ministry(name, coord: coord, members: members));
      emit(SuccessNewMinistryState());
    } catch (e) {
      emit(ErrorNewMinistryState());
    }
  }
}
