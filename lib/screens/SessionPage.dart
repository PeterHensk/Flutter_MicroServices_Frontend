import 'package:flutter/material.dart';
import '../data-access/facades/MaintenanceFacade.dart';
import '../data-access/facades/SessionFacade.dart';
import '../widgets/session/SessionTile.dart';
import '../widgets/general/NavBar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SessionPage extends StatefulWidget {
  final SessionFacade sessionFacade;
  final MaintenanceFacade maintenanceFacade;
  final String token;

  const SessionPage({super.key,
    required this.sessionFacade,
    required this.maintenanceFacade,
    required this.token});

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
      drawer: NavBar(sessionFacade: widget.sessionFacade, maintenanceFacade: widget.maintenanceFacade),
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
            child: SessionTile(token: widget.token),
          ),
        ],
      ),
    );
  }
}