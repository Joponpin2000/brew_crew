import 'package:brew_crew/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

class AuthService {
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  // create user obj based on firebaseuser
  CurrentUser _userFromFireBaseUser(auth.User user) {
    return user != null ? CurrentUser(uid: user.uid) : null;
  }

  // auth change user strem
  Stream<CurrentUser> get user {
    return _auth.authStateChanges().map(_userFromFireBaseUser);
  }

  // Sign in Anon
  Future signInAnon() async {
    try {
      auth.UserCredential result = await _auth.signInAnonymously();
      auth.User user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      auth.UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      auth.User user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      auth.UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      auth.User user = result.user;
      return _userFromFireBaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
