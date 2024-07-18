import 'package:flutter/material.dart';
import '../data-access/facades/SessionFacade.dart';

class StartSessionPage extends StatelessWidget {
  final SessionFacade sessionFacade;
  final String token;

  StartSessionPage({required this.sessionFacade, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Start Session")),
      body: Center(
        child: Text("Token: $token"),
      ),
    );
  }
}
