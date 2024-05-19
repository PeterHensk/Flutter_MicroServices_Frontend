import 'package:flutter/material.dart';
import '../services/authentication.dart';

class SignInButton extends StatelessWidget {
  final Authentication auth = Authentication();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('Sign in with Google'),
      onPressed: () async {
        final userCredential = await auth.signInWithGoogle();
        if (userCredential != null) {
          final token = await userCredential.user?.getIdToken();
          if (token != null) {
            print('Token: $token');
          }
        }
      },
    );
  }
}