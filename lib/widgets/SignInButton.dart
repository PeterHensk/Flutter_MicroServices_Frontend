import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../data-access/ApiServices.dart';
import 'ErrorToast.dart';

class SignInButton extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(AppLocalizations.of(context)!.signInWithGoogle),
      onPressed: () async {
        try {
          UserCredential userCredential = await _auth.signInWithPopup(GoogleAuthProvider());
          User? user = userCredential.user;
          if (user != null) {
            String? token = await user.getIdToken();
            if (token != null) {
              final response = await ApiServices.postWhoAmI(token);
            }
          }
        } catch (e) {
          ErrorToast.showError("Error during sign-in: $e");
        }
      },
    );
  }
}