import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<AuthResult> signUp(String _email, String _password) async {
    AuthResult authResult = await _auth.createUserWithEmailAndPassword(
        email: _email, password: _password);
    return authResult;
  }

  Future<AuthResult> logIn(String _email, String _password) async {
    AuthResult authResult = await _auth.signInWithEmailAndPassword(
        email: _email, password: _password);
    return authResult;
  }

  Future<FirebaseUser> getUser() async {
    return await _auth.currentUser();
  }
  Future<void> signOut() async {
    await _auth.signOut();
  }
}
