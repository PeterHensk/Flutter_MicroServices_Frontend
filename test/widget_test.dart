import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';
import 'package:frontend/widgets/SignInButton.dart';
import 'package:frontend/widgets/WelcomePage.dart';
import 'package:mockito/mockito.dart';
import 'authentication_mock.dart';

void main() {
  testWidgets('Shows SignInButton when no user is logged in', (WidgetTester tester) async {
    // Mock the Authentication service to return null for authStateChanges
    final mockAuth = MockAuthentication();
    when(mockAuth.authStateChanges).thenAnswer((_) => Stream.value(null));

    // Verify that the SignInButton is displayed
    expect(find.byType(SignInButton), findsOneWidget);
  });

  testWidgets('Shows WelcomePage when a user is logged in', (WidgetTester tester) async {
    // Mock the Authentication service to return a user for authStateChanges
    final mockAuth = MockAuthentication();
    when(mockAuth.authStateChanges).thenAnswer((_) => Stream.value(MockUser()));


    // Verify that the WelcomePage is displayed
    expect(find.byType(WelcomePage), findsOneWidget);
  });
}