import 'package:firebase_auth/firebase_auth.dart';

class EmailAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> createUser(
      {required String name,
      required String email,
      required String pwd}) async {
    try {
      final credentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: pwd);
      credentials.user!.updateDisplayName(name);
      credentials.user!.sendEmailVerification();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<User?> validateUser(
      {required String email, required String pwd}) async {
    try {
      final credentials =
          await _auth.signInWithEmailAndPassword(email: email, password: pwd);
      if (credentials.user!.emailVerified) {
        return credentials.user;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      print("Error al enviar el correo electrónico de restablecimiento: $e");
    }
  }

  Future signOut() async {
    _auth.signOut();
  }
}
