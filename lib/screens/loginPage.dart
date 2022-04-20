import 'dart:ui';

import 'package:artist/assets/loginUtils/facebook.dart';
import 'package:artist/assets/loginUtils/google.dart';
import 'package:artist/assets/loginUtils/phone.dart';
import 'package:artist/assets/loginUtils/signInUser.dart';
import 'package:artist/screens/signUp.dart';
import 'package:artist/utils/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var obsText = true;
  var theme;

  void sharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    theme = prefs.get('theme') ?? "color";
  }

  @override
  void initState() {
    // TODO: implement initState
    sharedPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passController = TextEditingController();
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Stack(
            children: [
              theme == "light"
                  ?lightBack()
                  :colorBack(),
              Column(
                children: [
                  SizedBox(
                    height: 500.h,
                  ),
                  SizedBox(
                    height: 300.h,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 75.w, right: 75.w),
                    child: Column(children: [
                      Container(
                        decoration: BoxDecoration(
                            color: theme == "light"
                                ? Colors.black26
                                : Colors.white38,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: TextField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            style:
                                GoogleFonts.merriweather(color: Colors.white),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle:
                                    GoogleFonts.ubuntu(color: Colors.white),
                                icon: Icon(
                                  Icons.email_outlined,
                                  color: Colors.white,
                                ),
                                hintText: "Enter Email")),
                      ),
                      SizedBox(height: 50.h),
                      Container(
                        decoration: BoxDecoration(
                            color: theme == "light"
                                ? Colors.black26
                                : Colors.white38,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: TextField(
                            controller: _passController,
                            obscureText: obsText == true ? true : false,
                            style:
                                GoogleFonts.merriweather(color: Colors.white),
                            decoration: InputDecoration(
                                suffixIcon: obsText == true
                                    ? IconButton(
                                        onPressed: () async {
                                          SharedPreferences _prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          setState(() {
                                            _prefs.setString("theme", "light");
                                            theme = _prefs.get("theme");
                                            obsText = false;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.visibility_outlined,
                                          color: Colors.white,
                                        ))
                                    : IconButton(
                                        onPressed: () async {
                                          SharedPreferences _prefs =
                                              await SharedPreferences
                                                  .getInstance();
                                          setState(() {
                                            _prefs.setString("theme", "color");
                                            theme = _prefs.get("theme");
                                            obsText = true;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.visibility_off_outlined,
                                          color: Colors.white,
                                        )),
                                border: InputBorder.none,
                                hintStyle:
                                    GoogleFonts.ubuntu(color: Colors.white),
                                icon: Icon(
                                  Icons.lock_outline_rounded,
                                  color: Colors.white,
                                ),
                                hintText: "Enter Password")),
                      ),
                      SizedBox(
                        height: 50.h,
                      ),
                      GestureDetector(
                          onTap: () {
                            TextEditingController _forgotPass =
                                TextEditingController();
                            Get.defaultDialog(
                                title: "Forgot Password?",
                                titleStyle: GoogleFonts.ubuntu(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50.sp),
                                content: Column(children: [
                                  Container(
                                    child: TextField(
                                      controller: _forgotPass,
                                      decoration: InputDecoration(
                                          hintText: "Enter Email"),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () async {
                                      FirebaseAuth _auth =
                                          FirebaseAuth.instance;
                                      try {
                                        await _auth.sendPasswordResetEmail(
                                            email: _forgotPass.text);
                                        Fluttertoast.showToast(
                                            msg:
                                                "Check your email to reset the password");
                                        Get.back();
                                      } on FirebaseAuthException catch (e) {
                                        Fluttertoast.showToast(
                                            msg: e.code == "user-not-found"
                                                ? "User does not exist"
                                                : e.code);
                                      }
                                    },
                                    child: Text(
                                      "Reset Password",
                                      style: GoogleFonts.ubuntu(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 50.sp),
                                    ),
                                    style: ButtonStyle(backgroundColor:
                                        MaterialStateProperty.resolveWith(
                                            (states) {
                                      return Colors.black26;
                                    })),
                                  )
                                ]));
                          },
                          child: Container(
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.redAccent),
                            ),
                            alignment: Alignment.topRight,
                          )),
                      SizedBox(
                        height: 150.h,
                      ),
                      GestureDetector(
                          onTap: () => _emailController.text == '' ||
                                  _passController.text == ''
                              ? Fluttertoast.showToast(
                                  msg: "Invalid email or password")
                              : EmailValidator.validate(
                                          _emailController.text) ==
                                      false
                                  ? Fluttertoast.showToast(
                                      msg: "Enter a valid email")
                                  : signInUser(_emailController.text,
                                      _passController.text),
                          child: Text(
                            "Login",
                            style: TextStyle(
                                fontSize: 65.sp,
                                color: theme == "light"
                                    ? Colors.black
                                    : Colors.white),
                            textAlign: TextAlign.center,
                          )),
                      SizedBox(
                        height: 20.h,
                      ),
                      GestureDetector(
                          onTap: () => Get.off(signUp()),
                          child: Container(
                            decoration: BoxDecoration(
                                color: theme == "light"
                                    ? Colors.black26
                                    : Colors.white38,
                                borderRadius: BorderRadius.circular((20))),
                            height: 100.h,
                            width: 500.h,
                            child: Center(
                                child: Text(
                              "Create an account",
                              style: TextStyle(
                                  color: theme == "light"
                                      ? Colors.black
                                      : Colors.white),
                            )),
                          )),
                      SizedBox(
                        height: 50.h,
                      ),
                      Center(
                          child: Text("OR",
                              style: TextStyle(
                                  fontSize: 50.sp,
                                  color: theme == "light"
                                      ? Colors.black
                                      : Colors.white))),
                      SizedBox(
                        height: 50.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                              onPressed: () {
                                Get.to(phoneLogin());
                              },
                              icon: Icon(
                                Icons.call,
                                size: 75.h,
                                color: theme == "light"
                                    ? Colors.black87
                                    : Colors.white,
                              )),
                          SizedBox(
                            width: 20.w,
                          ),
                          IconButton(
                              onPressed: () {
                                signInWithGoogle();
                              },
                              icon: Icon(
                                FontAwesomeIcons.google,
                                color: Colors.redAccent,
                              )),
                          SizedBox(
                            width: 20.w,
                          ),
                          IconButton(
                              onPressed: () {
                                signInWithFacebook();
                              },
                              icon: Icon(
                                FontAwesomeIcons.facebook,
                                color: Colors.blue,
                              ))
                        ],
                      )
                    ]),
                  )
                ],
              ),
              theme=="light"?Container():logoHead()
            ],
          ),
        ));
  }
}
