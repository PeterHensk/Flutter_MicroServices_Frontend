import 'package:flutter/material.dart';
import '../widgets/session/SessionList.dart';
import '../widgets/general/NavBar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SessionPage extends StatefulWidget {
  @override
  _SessionPageState createState() => _SessionPageState();
}

class _SessionPageState extends State<SessionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.session_screen_title),
      ),
      drawer: NavBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(AppLocalizations.of(context)!.session_screen_intro,
              style: const TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: SessionList(),
          ),
        ],
      ),
    );
  }
}