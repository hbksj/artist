import 'package:artist/assets/loginUtils/newUser.dart';
import 'package:artist/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

Future<UserCredential> signInWithGoogle() async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  UserCredential userCredential = await _auth.signInWithCredential(credential);
  if (userCredential.additionalUserInfo!.isNewUser) {
    Get.off(newUser());

  } else
  {
Get.off(()=>HomePage());

  }

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
