import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import '../paths.dart';
import 'app_auth_state.dart';

class AuthController extends Cubit<AppAuthState> {
  AuthController() : super(LoadingAuthState()) {
    init();
  }

  void init() async {
    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);
    final userCollection =
        FirebaseFirestore.instance.collection(Paths.userCollection);
    final database = await userCollection.get();

    FirebaseAuth.instance.userChanges().listen((user) async {
      if (user != null) {
        emit(LoggedAuthState());
        final index = database.docs.indexWhere((e) => e.id == user.uid);
        if (index == -1) {
          userCollection.doc(user.uid).set({'name': user.displayName});
        } else {
          final querySnapshot = await userCollection.doc(user.uid).get();
          final data = querySnapshot.data();
          final currentName = data?['name'] ?? '';
          if (user.displayName != currentName) {
            userCollection.doc(user.uid).set({'name': user.displayName});
          }
        }
      } else {
        emit(NotLoggedAuthState());
      }
    });
  }
}
