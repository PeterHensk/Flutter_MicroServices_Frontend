import 'package:flutter/material.dart';
import 'package:frontend/screens/UserManagement.dart';
import 'package:provider/provider.dart';
import '../screens/SignInPage.dart';
import '../screens/StationManagement.dart';
import '../services/authentication.dart';
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
          DrawerHeader(
            child: Text('Navigation'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('User management'),
            onTap: () async {
              await auth.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => UserManagement())
              );
            },
          ),
          ListTile(
            title: Text('Station management'),
            onTap: () async {
              await auth.signOut();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => StationManagement())
              );
            },
          ),
          ListTile(
            title: Text('Log off'),
            onTap: () async {
              await auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
          ),
          SwitchListTile(
            title: Text('Dark Mode'),
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