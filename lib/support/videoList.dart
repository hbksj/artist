import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class videoList extends StatefulWidget {
  const videoList({Key? key}) : super(key: key);

  @override
  State<videoList> createState() => _videoListState();
}

class _videoListState extends State<videoList> {
  var categoryIndex=0;
  @override
  Widget build(BuildContext context) {
    return Container(height: double.infinity,child:ListView(physics: BouncingScrollPhysics(),
      children: [
        Container(
          height: 150.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.all(20.h),
              child: Text(
                "Videos",
                style: GoogleFonts.merriweather(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 50.sp),
              ),
            ),
            Padding(padding:EdgeInsets.only(right: 20.h),child:Row(
              children: [
                GestureDetector(
                  child: Text(
                    "New",
                    style: GoogleFonts.merriweather(color: Colors.white,
                        fontSize: 40.sp, fontWeight: FontWeight.bold),
                  ),onTap: (){setState(() {
                    categoryIndex=0;

                  });},
                ),
                Text(" | ",style: TextStyle(color: Colors.white),),
                GestureDetector(
                  child: Text(
                    "Popular",
                    style: GoogleFonts.merriweather(color: Colors.white,
                        fontSize: 40.sp, fontWeight: FontWeight.bold),
                  ),onTap: (){setState(() {
                  categoryIndex=0;
                });},
                )
              ],
            )),
          ],
        ),
        // Container(
        //   height: 100.h,
        //   color: Colors.red,
        // ),
        // Container(
        //   height: 100.h,
        //   color: Colors.green,
        // )
      ],
    ));
  }
}
