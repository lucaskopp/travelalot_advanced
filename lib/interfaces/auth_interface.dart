import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthInterface {
  Future<User> signInWithGoogle();

  Future<void> signOut();

  Future<bool> isSignedIn();

  Future<String> getUserEmail();

  Future<Map<String, String>> get headers;
}
