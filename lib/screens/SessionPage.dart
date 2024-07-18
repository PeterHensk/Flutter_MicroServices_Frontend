import 'package:flutter/material.dart';
import '../data-access/facades/SessionFacade.dart';
import '../widgets/session/SessionList.dart';
import '../widgets/general/NavBar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SessionPage extends StatefulWidget {
  final SessionFacade sessionFacade;

  const SessionPage({super.key,
    required this.sessionFacade});

  @override
  _SessionPageState createState() {
    return _SessionPageState();
  }
}

class _SessionPageState extends State<SessionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.session_screen_title),
      ),
      drawer: NavBar(sessionFacade: widget.sessionFacade),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.session_screen_intro,
                    style: const TextStyle(fontSize: 16.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
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