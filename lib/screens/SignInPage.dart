import 'package:flutter/material.dart';
import '../data-access/facades/SessionFacade.dart';
import '../widgets/general/SignInButton.dart';

class SignInPage extends StatelessWidget {
  final SessionFacade sessionFacade;

  const SignInPage({super.key, required this.sessionFacade});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Welcome!',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            const Text(
              'Please sign in to continue.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            SignInButton(sessionFacade: sessionFacade,),
          ],
        ),
      ),
    );
  }
}