import 'package:firebase_auth/firebase_auth.dart';

class GithubAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGitHub() async {
    final OAuthProvider oAuthProvider = OAuthProvider('github.com');
    oAuthProvider.addScope('user');
    final credential = await _auth.signInWithPopup(oAuthProvider);
    return credential.user;
  }
}
