import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data-access/facades/MaintenanceFacade.dart';
import '../../models/Dto/RunningSessionDto.dart';
import '../../screens/SignInPage.dart';
import '../../screens/SessionPage.dart';
import '../../screens/MaintenancePage.dart';

import '../../screens/StationManagement.dart';
import '../../screens/UserManagement.dart';
import '../../services/authentication.dart';
import '../../data-access/facades/SessionFacade.dart';
import '../session/RunningSession.dart';
import 'ThemeNotifier.dart';

class NavBar extends StatelessWidget {
  final Authentication auth = Authentication();
  final SessionFacade sessionFacade;
  final MaintenanceFacade maintenanceFacade;

  NavBar({super.key, required this.sessionFacade, required this.maintenanceFacade});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    final token = themeNotifier.token ?? "";
    final firstName = themeNotifier.firstName ?? "";
    final lastName = themeNotifier.lastName ?? "";

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text('Navigation'),
          ),
          ListTile(
            title: const Text('Users'),
            onTap: () async {
              await auth.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserManagement(sessionFacade: sessionFacade, maintenanceFacade: maintenanceFacade)));
            },
          ),
          ListTile(
            title: const Text('Stations'),
            onTap: () async {
              await auth.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => StationManagement(token: token, sessionFacade: sessionFacade, maintenanceFacade: maintenanceFacade)));
            },
          ),
          ListTile(
            title: const Text('Session details'),
            onTap: () async {
              await auth.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SessionPage(sessionFacade: sessionFacade, maintenanceFacade: maintenanceFacade)));
            },
          ),
          ListTile(
            title: const Text('Maintenance reports'),
            onTap: () async {
              await auth.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MaintenancePage(token: token, maintenanceFacade: maintenanceFacade,)));
            },
          ),
          ListTile(
            title: const Text('Log off'),
            onTap: () async {
              await auth.signOut();
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignInPage(sessionFacade: sessionFacade, maintenanceFacade: maintenanceFacade)));
            },
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: themeNotifier.isDarkMode,
            onChanged: (value) {
              themeNotifier.toggleTheme();
            },
          ),
          FutureBuilder<RunningSessionDto?>(
            future: sessionFacade.getRunningSession(token),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const ListTile(title: Text('Loading session...'));
              } else if (snapshot.hasError) {
                return const ListTile(title: Text('Error fetching session'));
              } else {
                return RunningSession(session: snapshot.data,
                                      sessionFacade: sessionFacade,
                                      token: token,
                                      firstName: firstName,
                                      lastName: lastName,
                                      maintenanceFacade: maintenanceFacade);
              }
            },
          ),
        ],
      ),
    );
  }
}