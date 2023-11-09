import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> createUser({required String email, required String pwd}) async {
    try {
      final credentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: pwd);
      credentials.user!.sendEmailVerification();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> validateUser(
      {required String email, required String pwd}) async {
    try {
      final credentials =
          await _auth.signInWithEmailAndPassword(email: email, password: pwd);
      return credentials.user!.emailVerified;
    } catch (e) {
      return false;
    }
  }
}
