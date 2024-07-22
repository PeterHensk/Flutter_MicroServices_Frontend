import 'package:flutter/material.dart';
import '../data-access/facades/MaintenanceFacade.dart';
import '../data-access/facades/SessionFacade.dart';
import '../widgets/general/NavBar.dart';

class HomePage extends StatelessWidget {
  final String firstName;
  final String lastName;
  final SessionFacade sessionFacade;
  final MaintenanceFacade maintenanceFacade;

  HomePage({
    required this.firstName,
    required this.lastName,
    required this.sessionFacade,
    required this.maintenanceFacade});

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
      drawer: NavBar(sessionFacade: sessionFacade, maintenanceFacade: maintenanceFacade),
      body: const Center(
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