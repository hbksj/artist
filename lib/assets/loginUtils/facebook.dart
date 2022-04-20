import 'package:artist/assets/loginUtils/newUser.dart';
import 'package:artist/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';

Future<UserCredential> signInWithFacebook() async {
  // Trigger the sign-in flow
  FirebaseAuth _auth = FirebaseAuth.instance;
  final LoginResult loginResult = await FacebookAuth.instance.login();

  // Create a credential from the access token
  final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken!.token);
  UserCredential userCredential = await _auth.signInWithCredential(facebookAuthCredential);
  if (userCredential.additionalUserInfo!.isNewUser) {
    Get.off(newUser());

  } else
  {
    Get.off(HomePage());

  }
  // Once signed in, return the UserCredential
  return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
}