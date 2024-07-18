import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;
  String? _token;
  String? _firstName;
  String? _lastName;

  ThemeNotifier() {
    _loadFromPrefs();
  }

  bool get isDarkMode => _isDarkMode;
  String? get token => _token;
  String? get firstName => _firstName;
  String? get lastName => _lastName;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    _saveToPrefs();
    notifyListeners();
  }

  _loadFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool('darkMode') ?? false;
    notifyListeners();
  }

  _saveToPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('darkMode', _isDarkMode);
  }

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  void setUserName(String firstName, String lastName) {
    _firstName = firstName;
    _lastName = lastName;
    notifyListeners();
  }
}
