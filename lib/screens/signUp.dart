import 'package:artist/assets/loginUtils/newUser.dart';
import 'package:artist/screens/loginPage.dart';
import 'package:artist/utils/theme.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

class signUp extends StatefulWidget {
  const signUp({Key? key}) : super(key: key);

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _cpassController = TextEditingController();
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

  Future signUp(@required var email, var pass) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      Fluttertoast.showToast(msg: "You have successfully signed up.");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(
            msg: 'The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            physics: NeverScrollableScrollPhysics(),
            child: Stack(children: [
              theme == "light" ? lightBack() : colorBack(),
              Column(children: [
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
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            style:
                                GoogleFonts.merriweather(color: Colors.white),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle:
                                    GoogleFonts.ubuntu(color: Colors.white),
                                icon: Icon(
                                  Icons.lock_outline_rounded,
                                  color: Colors.white,
                                ),
                                hintText: "Enter Password")),
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
                            controller: _cpassController,
                            obscureText: obsText == true ? true : false,
                            keyboardType: TextInputType.visiblePassword,
                            style:
                                GoogleFonts.merriweather(color: Colors.white),
                            decoration: InputDecoration(
                                suffixIcon: obsText == true
                                    ? IconButton(
                                        onPressed: () {
                                          setState(() {
                                            obsText = false;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.visibility_outlined,
                                          color: Colors.white,
                                        ))
                                    : IconButton(
                                        onPressed: () {
                                          setState(() {
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
                                hintText: "Confirm Password")),
                      ),
                      SizedBox(
                        height: 150.h,
                      ),
                      GestureDetector(
                          onTap: () {
                            _emailController.text == '' ||
                                    _passController.text == ''
                                ? Fluttertoast.showToast(
                                    msg: "Invalid email or password.")
                                : EmailValidator.validate(
                                            _emailController.text) ==
                                        false
                                    ? Fluttertoast.showToast(
                                        msg: "Enter a valid email")
                                    : _passController.text ==
                                            _cpassController.text
                                        ? signUp(_emailController.text,
                                            _passController.text)
                                        : Fluttertoast.showToast(
                                            msg: "Passwords do not match");
                          },
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.lightBlueAccent,
                                  borderRadius: BorderRadius.circular((20))),
                              height: 100.h,
                              width: 350.w,
                              child: Center(
                                  child: Text(
                                "Sign Up",
                                style: GoogleFonts.ubuntu(
                                    fontSize: 60.sp, color: Colors.white),
                                textAlign: TextAlign.center,
                              )))),
                      SizedBox(
                        height: 20.h,
                      ),
                      GestureDetector(
                          onTap: () => Get.off(LoginPage()),
                          child: Container(
                            decoration: BoxDecoration(
                                color: theme == "light"
                                    ? Colors.black26
                                    : Colors.white38,
                                borderRadius: BorderRadius.circular((20))),
                            height: 100.h,
                            width: 350.w,
                            child: Center(
                                child: Text(
                              "Login",
                              style: TextStyle(
                                color: theme == "light"
                                    ? Colors.black
                                    : Colors.white,
                              ),
                            )),
                          ))
                    ]))
              ]),
              theme == "light"
                  ? Container()
                  : Container(
                      child: Positioned(
                      child: Image.asset(
                        "lib/assets/logo/logo.png",
                      ),
                      height: 500.w,
                      left: Get.width / 2 - 250.w,
                    )),
            ])));
  }
}
