import 'package:dti/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googlesignin = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googlesignin.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      return e.toString();
    }

    notifyListeners();
  }

  Future logout() async {
    await googlesignin.disconnect();
    FirebaseAuth.instance.signOut();
    const Login();
  }
}
