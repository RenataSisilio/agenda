import 'package:flutter/material.dart';
import 'package:flutterfire_ui/auth.dart';

import '../ids.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      oauthButtonVariant: OAuthButtonVariant.icon,
      providerConfigs: const [
        EmailProviderConfiguration(),
        GoogleProviderConfiguration(clientId: googleClientId),
      ],
      actions: [
        ForgotPasswordAction(((context, email) {
          Navigator.of(context)
              .pushNamed('/forgot-password', arguments: {'email': email});
        })),
        AuthStateChangeAction(
          (context, state) {
            if (state is SignedIn || state is UserCreated) {
              var user = state is SignedIn
                  ? state.user
                  : (state as UserCreated).credential.user;
              if (user == null) {
                return;
              }
              if (state is UserCreated) {
                user.updateDisplayName(user.email!.split('@')[0]);
              }
              if (!user.emailVerified) {
                user.sendEmailVerification();
                const snackBar = SnackBar(content: Text('Verifique seu email'));
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
              Navigator.of(context).pushReplacementNamed('/');
            }
          },
        ),
      ],
    );
  }
}
