import 'package:bloc/bloc.dart';

import '../../shared/ministry_repository.dart';
import 'ministry_list_states.dart';

class MinistryListController extends Cubit<MinistryListState> {
  MinistryListController(this.repository)
      : super(LoadingMinistryListState()) {
    _init();
  }

  final MinistryRepository repository;

  void _init() async {
    emit(LoadingMinistryListState());
    try {
      final ministries = await repository.getAllMinistries();
      emit(SuccessMinistryListState(ministries));
    } catch (e) {
      emit(ErrorMinistryListState());
    }
  }
}
