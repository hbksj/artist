import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:artist/external_fn/navScreen.dart';
import 'package:artist/screens/Enquiry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../assets/icon/rsicon.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var _bottomNavIndex=0;
  final iconList = <IconData>[
    Icons.home,
    FontAwesomeIcons.calendar,
    RsIcon.rsicon,
    Icons.video_settings,
    FontAwesomeIcons.user
  ];
             @override
  void initState() {
    // TODO: implement initState
               setState(() {

               });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(elevation: 10.0,
        backgroundColor:Get.theme.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          "PartyOn",
          style:
          GoogleFonts.dancingScript(color: Colors.redAccent, fontSize:80.sp),
        ),
        actions: [
          GestureDetector(onTap: (){
            Get.to(Enquiry());
          },
              child: const Icon(
            Icons.question_answer_outlined,
            color: Colors.white,
          )),
          Container(
            width: 10.w,
          ),
          IconButton(
              onPressed: () {},
              icon: const FaIcon(FontAwesomeIcons.peopleGroup))
        ],
      ),
      body:  NavigationScreen(
      _bottomNavIndex,
    ),bottomNavigationBar: AnimatedBottomNavigationBar(
      backgroundColor:Get.theme.primaryColor,
      activeColor: Colors.red,
      inactiveColor: Colors.white,
      icons: iconList,
      activeIndex: _bottomNavIndex,
      gapLocation: GapLocation.none,
      notchSmoothness: NotchSmoothness.verySmoothEdge,

      iconSize: 60.h,
      onTap: (index) => setState(() => _bottomNavIndex = index),
      //other params
    ),
    );
  }
}
