import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:frontend/models/Dto/UserDto.dart';
import 'package:frontend/screens/HomePage.dart';
import 'package:frontend/screens/SignInPage.dart';
import 'package:frontend/screens/StartSessionPage.dart';
import 'package:frontend/widgets/general/ErrorToast.dart';
import 'package:frontend/widgets/general/ThemeNotifier.dart';
import 'package:provider/provider.dart';
import 'package:frontend/data-access/facades/SessionFacade.dart';
import 'package:frontend/data-access/services/SessionService.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart' as http;
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await _initializeApp();
  final sessionFacade = SessionFacade(SessionService());
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: MyApp(sessionFacade: sessionFacade),
    ),
  );
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
  final SessionFacade sessionFacade;

  MyApp({super.key, required this.sessionFacade});

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MultiProvider(
      providers: [
        Provider(create: (_) => SessionFacade(SessionService())),
      ],
      child: MaterialApp(
        title: 'Flutter App',
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        home: StreamBuilder<User?>(
          stream: _auth.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              User? user = snapshot.data;
              if (user == null) {
                return SignInPage(sessionFacade: sessionFacade,);
              } else {
                return FutureBuilder<String?>(
                  future: user.getIdToken(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else {
                        String? token = snapshot.data;
                        if (token != null) {
                          themeNotifier.setToken(token);
                          return FutureBuilder<http.Response>(
                            future: SessionService.postWhoAmI(token),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.done) {
                                if (snapshot.hasError) {
                                  return Center(child: Text('Error: ${snapshot.error}'));
                                } else {
                                  var response = snapshot.data;
                                  if (response != null) {
                                    if (response.statusCode == 201) {
                                      try {
                                        var data = UserDto.fromJson(jsonDecode(response.body));
                                        themeNotifier.setUserName(data.firstName, data.lastName);
                                        return HomePage(
                                          firstName: data.firstName,
                                          lastName: data.lastName,
                                          sessionFacade: sessionFacade
                                        );
                                      } catch (e) {
                                        return Center(child: Text('Failed to parse user data: $e'));
                                      }
                                    } else {
                                      return Center(child: Text('Failed to load user data: ${response.statusCode}'));
                                    }
                                  } else {
                                    return Center(child: Text('No response from server'));
                                  }
                                }
                              } else {
                                return Center(child: CircularProgressIndicator());
                              }
                            },
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
        onGenerateRoute: (settings) {
          final token = themeNotifier.token;
          final firstName = themeNotifier.firstName;
          final lastName = themeNotifier.lastName;
          if (settings.name == '/StartSessionPage') {
            if (token != null) {
              final sessionFacade = Provider.of<SessionFacade>(context, listen: false);
              return MaterialPageRoute(
                builder: (context) => StartSessionPage(sessionFacade: sessionFacade, token: token),
              );
            } else {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ErrorToast(message: 'Token is missing').show(context);
              });
              return MaterialPageRoute(
                builder: (context) => HomePage(
                  firstName: firstName ?? 'FirstName',
                  lastName: lastName ?? 'LastName',
                  sessionFacade: sessionFacade
                ),
              );
            }
          }
          // Handle other routes or return null
          return null;
        },
      ),
    );
  }
}
