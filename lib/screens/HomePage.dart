import 'package:flutter/material.dart';
import '../widgets/general/NavBar.dart';

class HomePage extends StatelessWidget {
  final String firstName;
  final String lastName;

  HomePage({required this.firstName, required this.lastName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                '$firstName $lastName',
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
      drawer: NavBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome to the Home Page!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Text(
              'This is where you can add more content.',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}