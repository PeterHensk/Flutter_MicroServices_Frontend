import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider.setCustomParameters({
      'client_id': dotenv.env['CLIENT_ID'],
    });

    final UserCredential userCredential = await _firebaseAuth.signInWithPopup(googleProvider);

    return userCredential;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}