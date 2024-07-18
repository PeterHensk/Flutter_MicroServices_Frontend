import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ErrorToast extends StatelessWidget {
  final String message;

  ErrorToast({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(); // This widget doesn't actually need to build anything.
  }

  void show(BuildContext context) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
}
