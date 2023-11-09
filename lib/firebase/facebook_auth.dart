import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class Facebook {
  Future<User?> signInWithFacebook() async {
    try {
      final LoginResult result =
          await FacebookAuth.instance.login(permissions: ['email']);

      if (result.status == LoginStatus.success) {
        final AuthCredential credential =
            FacebookAuthProvider.credential(result.accessToken!.token);
        final UserCredential authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);
        final User? user = authResult.user;
        return user;
      } else {
        // El usuario canceló el inicio de sesión o ocurrió un error.
        return null;
      }
    } catch (e) {
      // Maneja cualquier error que pueda ocurrir durante el proceso de autenticación.
      print('Error al iniciar sesión con Facebook: $e');
      return null;
    }
  }
}
