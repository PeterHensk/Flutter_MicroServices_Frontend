import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';
import 'package:frontend/services/authentication.dart';

class MockAuthentication extends Mock implements Authentication {
  @override
  Stream<User?> get authStateChanges => Stream.value(MockUser());
}

class MockUser extends Mock implements User {}