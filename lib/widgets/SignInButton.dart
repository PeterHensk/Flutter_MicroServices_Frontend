import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:frontend/models/Dto/UserDto.dart';
import '../data-access/services/SessionService.dart';
import '../screens/HomePage.dart';
import 'ErrorToast.dart';

class SignInButton extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(
          AppLocalizations.of(context)!.signInPage_button_signInWithGoogle),
      onPressed: () async {
        try {
          UserCredential userCredential =
              await _auth.signInWithPopup(GoogleAuthProvider());
          User? user = userCredential.user;
          if (user != null) {
            String? token = await user.getIdToken();
            if (token != null) {
              final response = await SessionService.postWhoAmI(token);
              var data = UserDto.fromJson(jsonDecode(response.body));
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(
                      firstName: data.firstName,
                      lastName: data.lastName
                    ),
                  ));
            }
          }
        } catch (e) {
          ErrorToast.showError("Error during sign-in: $e");
        }
      },
    );
  }
}
