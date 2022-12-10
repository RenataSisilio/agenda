import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_auth_state.dart';
import 'auth_controller.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthController, AppAuthState>(
      listener: (context, state) {
        if (state is LoggedAuthState) {
          Navigator.of(context).pushReplacementNamed('/');
        }
        if (state is NotLoggedAuthState) {
          Navigator.of(context).pushReplacementNamed('/sign-in');
        }
      },
      builder: (context, state) {
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
