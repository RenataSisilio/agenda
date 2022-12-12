import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../calendar_repository.dart';
import 'new_event_state.dart';

class NewEventController extends Cubit<NewEventState> {
  NewEventController() : super(LoadingNewEventState()) {
    getMyMinistries();
    getUserNames();
  }

  final firestoreRepo = CalendarFirestoreRepository();
  final userNames = <String, String>{};

  void getMyMinistries() async {
    emit(LoadingNewEventState());
    try {
      final id = FirebaseAuth.instance.currentUser!.uid;
      final ministries = await firestoreRepo.getMinistries(id, coord: true);
      emit(SuccessNewEventState(ministries));
    } catch (e) {
      emit(ErrorNewEventState());
    }
  }

  void getUserNames() async {
    final map = await firestoreRepo.getUserNames();
    userNames.addAll(map);
  }
}
