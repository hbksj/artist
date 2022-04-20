import 'package:artist/assets/loginUtils/newUser.dart';
import 'package:artist/screens/home.dart';
import 'package:artist/support/flash_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class phoneLogin extends StatefulWidget {
  const phoneLogin({Key? key}) : super(key: key);

  @override
  State<phoneLogin> createState() => _phoneLoginState();
}

class _phoneLoginState extends State<phoneLogin> {
  var sendOtp = false;
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  void _phoneSignIn(var phone) async {
    await auth.verifyPhoneNumber(
      phoneNumber: ('+91'+phone).toString(),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!

        // Sign the user in (or link) with the auto-generated credential
        await auth.signInWithCredential(credential);
        UserCredential userCredential =
            await auth.signInWithCredential(credential);

      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String verificationId, int? resendToken) async {

        Get.defaultDialog(title: "Enter OTP",
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _otpController,
                      inputFormatters: [LengthLimitingTextInputFormatter(6)],
                    ),
                  ],
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Confirm"),
                    textColor: Colors.white,
                    color: Colors.blue,
                    onPressed: () async {

                      final code = _otpController.text.trim();


                      try{AuthCredential credential = PhoneAuthProvider.
                      credential(
                          verificationId: verificationId, smsCode: code);


                      UserCredential result = await auth.signInWithCredential(
                          credential);




                        if(result.user!=null)
                        {result.user?.displayName==null
                            ?{ Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>newUser()))}
                            :{ Get.off(()=>HomePage())};}
                        else
                          Fluttertoast.showToast(msg: "User does not exist");

                      }catch(e){
                        _otpController.clear();
                        Fluttertoast.showToast(msg: 'Enter a valid code');
                        print(e);
                      }
                    },
                  )
                ],
              );


      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(children: [
          Container(
            width: Get.width,
            height: Get.height,
            child: Opacity(
              child: Image.asset(
                "lib/assets/images/login_back.png",
              ),
              opacity: 0.2,
            ),
            color: Color.fromRGBO(210, 247, 240, 1),
          ),
          Padding(
            padding: EdgeInsets.only(left: 75.w, right: 75.w),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.black26,
                  ),
                  child: TextField(
                      autofocus: true,
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      keyboardType: TextInputType.number,
                      controller: _phoneController,
                      decoration: InputDecoration(
                          prefixText: '+91',
                          border: InputBorder.none,
                          hintStyle: GoogleFonts.ubuntu(color: Colors.white),
                          icon: Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                          hintText: "Enter mobile number"))),
              SizedBox(
                height: 30.h,
              ),
              ElevatedButton(
                style: ButtonStyle(backgroundColor:
                    MaterialStateProperty.resolveWith((states) {
                  return Colors.black45;
                })),
                onPressed: () {
                  _phoneController.value.text.length < 10
                      ? Fluttertoast.showToast(
                          msg: "Enter a valid number",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 45.sp)
                      : _phoneSignIn(_phoneController.text);
                },
                child: Text("Send OTP"),
              ),
              SizedBox(
                height: 50.h,
              ),



            ]),
          ),
        ]));
  }
}
