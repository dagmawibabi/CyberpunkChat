import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future signUp(email, password) async {
    try {
      dynamic signUpResult = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return [true, signUpResult];
    } catch (e) {
      return [false, e];
    }
  }

  Future signIn(email, password) async {
    try {
      dynamic signInResult = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      return [true, signInResult.user];
    } catch (e) {
      return [false, e];
    }
  }

  Future signInAnonymous() async {
    try {
      dynamic signInAnonymous = await auth.signInAnonymously();
      return [true, signInAnonymous];
    } catch (e) {
      return [false, e];
    }
  }
}
