import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import 'app_auth_state.dart';

class AuthController extends Cubit<AppAuthState> {
  AuthController() : super(LoadingAuthState()) {
    init();
  }

  void init() async {
    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        emit(LoggedAuthState());
      } else {
        emit(NotLoggedAuthState());
      }
    });
  }
}
