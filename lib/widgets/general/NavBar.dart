import 'package:flutter/material.dart';
import 'package:frontend/screens/SessionPage.dart';
import 'package:frontend/screens/UserManagement.dart';
import 'package:provider/provider.dart';
import '../../screens/SignInPage.dart';
import '../../screens/StationManagement.dart';
import '../../services/authentication.dart';
import 'ThemeNotifier.dart';

class NavBar extends StatelessWidget {
  final Authentication auth = Authentication();

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

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
            title: const Text('User management'),
            onTap: () async {
              await auth.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => UserManagement())
              );
            },
          ),
          ListTile(
            title: const Text('Station management'),
            onTap: () async {
              await auth.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => StationManagement())
              );
            },
          ),
          ListTile(
            title: const Text('Session details'),
            onTap: () async {
              await auth.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SessionPage())
              );
            },
          ),
          ListTile(
            title: const Text('Log off'),
            onTap: () async {
              await auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
          ),
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: themeNotifier.isDarkMode,
            onChanged: (value) {
              themeNotifier.toggleTheme();
            },
          ),
        ],
      ),
    );
  }
}