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

  Future<FirebaseUser> signInWithGoogle() async {
    final GoogleSignInAccount user = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuthentication =
        await user.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuthentication.idToken,
      accessToken: googleAuthentication.accessToken,
    );
    await _signInWithCredentials(credential);
    return _firebaseAuth.currentUser();
  }

  Future<void> _signInWithCredentials(AuthCredential credential) {
    return _firebaseAuth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }

  Future<bool> isSignedIn() async {
    final currentUser = await _firebaseAuth.currentUser();
    return currentUser != null;
  }

  Future<String> getUserEmail() async {
    return (await _firebaseAuth.currentUser()).email;
  }
}
