import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../interfaces/auth_interface.dart';

class AuthData implements AuthInterface {
  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  AuthData({FirebaseAuth firebaseAuth, GoogleSignIn googleSignIn})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ??
            GoogleSignIn(
              scopes: [
                'email',
                'https://www.googleapis.com/auth/gmail.readonly',
              ],
            );

  Future<User> signInWithGoogle() async {
    final GoogleSignInAccount user = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuthentication =
        await user.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleAuthentication.idToken,
      accessToken: googleAuthentication.accessToken,
    );
    await _signInWithCredentials(credential);

    return _firebaseAuth.currentUser;
  }

  Future<void> _signInWithCredentials(AuthCredential credential) {
    return _firebaseAuth.signInWithCredential(credential);
  }

  Future<Map<String, String>> get headers async {
    GoogleSignInAccount account = await _googleSignIn.signIn();
    // I made _googleSignIn.signInSilently() _googleSignIn to fix logout issues; do not know if this was the right fix
    return await account.authHeaders;
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.disconnect(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser =  _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<String> getUserEmail() async {
    return _firebaseAuth.currentUser.email;
  }
}
