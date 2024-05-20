import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'google_auth_service.g.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication?.accessToken,
      idToken: googleSignInAuthentication?.idToken,
    );

    final UserCredential authResult = await _auth.signInWithCredential(credential);
    final User? user = authResult.user;

    return user;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  User getCurrentUser() {
    return _auth.currentUser!;
  }
}

@Riverpod(keepAlive: true)
GoogleAuthService googleAuthService(GoogleAuthServiceRef ref) {
  return GoogleAuthService();
}
