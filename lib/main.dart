import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/screens/HomePage.dart';
import 'package:frontend/screens/SignInPage.dart';
import 'data-access/ApiServices.dart';
import 'firebase_options.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  _initializeApp().then((_) {
    runApp(MyApp());
  });
}

Future<void> _initializeApp() async {
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    print('Error during initialization: $e');
  }
}

class MyApp extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StreamBuilder(
        stream: _auth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            User? user = snapshot.data;
            if (user == null) {
              return SignInPage();
            } else {
              return FutureBuilder(
                future: user.getIdToken(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    String? token = snapshot.data;
                    if (token != null) {
                      return FutureBuilder(
                        future: ApiServices.postWhoAmI(token),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            var response = snapshot.data;
                            var data = jsonDecode(response!.body);
                            return HomePage(
                              firstName: data['firstName'],
                              lastName: data['lastName'],
                            );
                          } else {
                            return CircularProgressIndicator();
                          }
                        },
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              );
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}