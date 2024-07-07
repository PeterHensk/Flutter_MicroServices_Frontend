import 'package:flutter/material.dart';
import '../widgets/SignInButton.dart';

class SignInPage extends StatelessWidget {
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
            Text(
              'Welcome!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'Please sign in to continue.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            SignInButton(),
          ],
        ),
      ),
    );
  }
}