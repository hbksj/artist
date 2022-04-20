import 'dart:async';
import 'package:artist/screens/home.dart';
import 'package:artist/screens/loginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';
import 'utils/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(1080, 2340),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: () => GetMaterialApp(
              builder: EasyLoading.init(),
              title: 'Artist App',
              theme: ThemeData(
                scaffoldBackgroundColor: Colors.black,
                textTheme: TextTheme(
                    bodyText1: GoogleFonts.ubuntu(fontSize: 65.sp),
                    bodyText2: GoogleFonts.ubuntu(fontSize: 50.sp),
                    button: TextStyle(fontSize: 45.sp)),

                appBarTheme:
                    AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.light),
                // This is the theme of your application.
                //
                // Try running your application with "flutter run". You'll see the
                // application has a blue toolbar. Then, without quitting the app, try
                // changing the primarySwatch below to Colors.green and then invoke
                // "hot reload" (press "r" in the console where you ran "flutter run",
                // or simply save your changes to "hot reload" in a Flutter IDE).
                // Notice that the counter didn't reset back to zero; the application
                // is not restarted.
                primaryColor: Colors.black,

              ),
              debugShowCheckedModeBanner: false,
              home: const HomePage(),
            ));
  }
}

class afterSplash extends StatefulWidget {
  const afterSplash({Key? key}) : super(key: key);

  @override
  State<afterSplash> createState() => _afterSplashState();
}

class _afterSplashState extends State<afterSplash> {


  @override
  void initState() {
     isSignIn().whenComplete(() {setState(() {

     });});
  }

  Future<void> isSignIn() async {
    preferences = await SharedPreferences.getInstance();
    if (await FirebaseAuth.instance.currentUser != null) {
      Get.off(()=>const HomePage());
      // signed in
    } else {
      Get.off(()=>const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
