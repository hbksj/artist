import 'package:artist/assets/loginUtils/newUser.dart';
import 'package:artist/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

Future signInUser(@required var email,var pass)async{

  try {
    EasyLoading.show(dismissOnTap: false);
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: pass
    ).whenComplete(() => EasyLoading.dismiss());

    credential.user!.displayName==null?Get.off(newUser()):Get.off(HomePage())?.whenComplete(() {
      Fluttertoast.showToast(msg: "Welcome ${credential.user?.displayName??"User"}");
    });

    print(credential.user!.displayName);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      Fluttertoast.showToast(msg: 'No user found for that email.');
    } else if (e.code == 'wrong-password') {
      Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
    }
  }

}
