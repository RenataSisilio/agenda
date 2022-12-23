import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'admin/ministry_list/ministry_list_page.dart';
import 'admin/new_ministry/new_ministry_page.dart';
import 'auth/auth_controller.dart';
import 'auth/forgot_password_screen.dart';
import 'auth/profile_page.dart';
import 'auth/sign_in_page.dart';
import 'auth/splash_page.dart';
import 'firebase_options.dart';
import 'calendar/home/home_page.dart';
import 'calendar/new_event/new_event_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(BlocProvider(
    create: (context) => AuthController(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => const HomePage(),
        '/splash': (context) => const SplashPage(),
        '/sign-in': (context) => const SignInPage(),
        '/forgot-password': (context) => const ForgotPasswordPage(),
        '/profile': (context) => const ProfilePage(),
        '/new-event': (context) => const NewEventPage(),
        '/admin': (context) => const MinistryListPage(),
        '/new-ministry': (context) => const NewMinistryPage(),
      },
      initialRoute: '/admin',
    );
  }
}
