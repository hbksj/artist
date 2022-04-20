import 'dart:async';

import 'package:artist/screens/home.dart';
import 'package:artist/support/videoList.dart';
import 'package:artist/utils/utils.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  bool _enabled = true;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(milliseconds: 750), () {
      setState(() {
        _enabled = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Stack(children: [
          Container(
            height: Get.height,
            decoration:
                const BoxDecoration(color: Color.fromRGBO(247, 0, 67, 1)),
          ),
          Column(
            children: [
              Container(
                height: 75.h,
              ),
              Container(
                height: 500.h,
                width: 500.h,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                child: user?.photoURL!=null?CircleAvatar(
                  backgroundImage: NetworkImage(user!.photoURL.toString()),
                  radius: 150.h,
                ):Text("Loading"),
              ),
              Container(
                height: 50.h,
              ),
              Text(
                user?.displayName.toString().toUpperCase() ?? "Loading",
                style: GoogleFonts.roboto(fontSize: 60.sp, color: Colors.white),
              ),
              SizedBox(height: 50.h),
              Container(
                height: Get.height - 750.h,
                width: Get.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(200.w),
                        topRight: Radius.circular(200.w)),
                    color: Get.theme.primaryColor),
                child: Column(

                  children: [
                    FutureBuilder(
                      future: FirebaseFirestore.instance
                          .collection('users')
                          .doc(user?.uid)
                          .collection('myEvents')
                          .get(),
                      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.data?.size == 0)
                          return  videoList();
                        // return new Container(
                        //     height: MediaQuery.of(context).size.height,
                        //     child: Center(
                        //         child: Column(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             crossAxisAlignment: CrossAxisAlignment.center,
                        //             children: [
                        //           Icon(
                        //             Icons.error_outline_rounded,
                        //             color: Colors.grey,
                        //             size: 40,
                        //           ),
                        //           AutoSizeText(
                        //             'Nothing to show.',
                        //             style: TextStyle(
                        //                 color: Colors.grey,
                        //                 fontWeight: FontWeight.bold,
                        //                 fontSize: 45.sp),
                        //           )
                        //         ])));
                        else {
                          return ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: snapshot.data?.docs.length,
                              itemBuilder: (context, index) {
                                //DocumentSnapshot doc = snapshot.data!.docs[index];
                                return StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance
                                      .collection("Artist")
                                      .doc(user?.uid)
                                      .collection("videos")
                                      .orderBy('time', descending: true)
                                      .snapshots(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.data?.size == 0) {
                                      EasyLoading.dismiss();
                                      return new Container(
                                          height:
                                              MediaQuery.of(context).size.height,
                                          child: Center(
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                Icon(
                                                  Icons.error_outline_rounded,
                                                  color: Colors.grey,
                                                  size: 40,
                                                ),
                                                AutoSizeText(
                                                  'Nothing to show.',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 45.sp),
                                                )
                                              ])));
                                    } else {
                                      EasyLoading.dismiss();
                                      return _enabled == true
                                          ? Shimmer.fromColors(
                                              baseColor: Colors.black54,
                                              highlightColor: Colors.black12,
                                              enabled: true,
                                              child: Column(
                                                children: [
                                                  Card(
                                                      color: Colors.grey[300],
                                                      elevation: 5.0,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20.0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          20.0))),
                                                      child: Container(
                                                        height: 200,
                                                        width: Get.width,
                                                      )).paddingAll(8),
                                                  Card(
                                                          color: Colors.grey[300],
                                                          elevation: 5.0,
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.only(
                                                                      topRight: Radius
                                                                          .circular(
                                                                              20.0),
                                                                      bottomRight:
                                                                          Radius.circular(
                                                                              20.0))),
                                                          child: Container(
                                                              height: 550.h,
                                                              width: Get.width))
                                                      .paddingAll(8),
                                                  Card(
                                                      color: Colors.grey[300],
                                                      elevation: 5.0,
                                                      shape: RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topRight: Radius
                                                                      .circular(
                                                                          20.0),
                                                                  bottomRight: Radius
                                                                      .circular(
                                                                          20.0))),
                                                      child: Container(
                                                        height: 200,
                                                        width: Get.width,
                                                      )).paddingAll(8.w),
                                                ],
                                              ))
                                          : new ListView(
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              children: snapshot.data!.docs
                                                  .map((document) {
                                                return videoList();
                                              }).toList(),
                                            );
                                    }
                                  },
                                );
                              });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          )
        ]));
  }
}

class videoList extends StatefulWidget {
  var name, date, link, likes, views;
  bool onClub, onUser;

  videoList(
      {this.name,
      this.date,
      this.link,
      this.likes,
      this.views,
      this.onClub = true,
      this.onUser = true});

  @override
  State<videoList> createState() => _videoListState();
}

class _videoListState extends State<videoList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250.h,
      width: Get.width / 1.2,
      child: Card(
        elevation: 5.0,
        color: Colors.transparent,
        child: Column(
          children: [

            Row(
              children: [
                Container(
                  width: 250.h,
                  height: 250.h,
                  decoration: BoxDecoration(color: Colors.grey),
                ),
                SizedBox(
                  width: 50.w,
                ),
                Container(
                  height: 250.h,
                  width: 275.w,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Views: 9999",
                          style:
                              GoogleFonts.ubuntu(fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                        Text(
                          "Likes: 999",
                          style:
                              GoogleFonts.ubuntu(fontWeight: FontWeight.bold,color: Colors.white),
                        ),
                      ]),
                ),
                SizedBox(
                  width: 25.w,
                ),
                Container(
                    height: 300.h,
                    child: Column(children: [
                      Row(children: [
                        Text("Club: ",style: TextStyle(color: Colors.white),),
                        Transform.scale(
                            scale: 0.7,
                            child: CupertinoSwitch(
                              value: widget.onUser,
                              onChanged: (value) {
                                setState(() {
                                  widget.onUser = value;
                                  print(widget.onUser);
                                });
                              },
                            ))
                      ]),
                      Row(
                        children: [
                          Text("User: ",style: TextStyle(color: Colors.white),),
                          Transform.scale(
                              scale: 0.7,
                              child: CupertinoSwitch(
                                value: widget.onClub,
                                onChanged: (value) {
                                  setState(() {
                                    widget.onClub = value;
                                    print(widget.onClub);
                                  });
                                },
                              )),
                        ],
                      ),
                      // Center(
                      //   child: RatingStars(
                      //     value: 4,
                      //     starBuilder: (index, color) => Icon(
                      //       Icons.star,
                      //       color: color,
                      //       size: 16,
                      //     ),
                      //     starCount: 5,
                      //     starSize: 16,
                      //     valueLabelRadius: 10,
                      //     maxValue: 5,
                      //     starSpacing: 2,
                      //     maxValueVisibility: true,
                      //     valueLabelVisibility: false,
                      //     animationDuration: Duration(milliseconds: 1000),
                      //     valueLabelPadding: const EdgeInsets.symmetric(
                      //         vertical: 1, horizontal: 8),
                      //     valueLabelMargin: const EdgeInsets.only(right: 8),
                      //     starOffColor: const Color(0xffe7e8ea),
                      //     starColor: const Color.fromRGBO(247, 0, 67, 1),
                      //   ),
                      // ),
                    ]))
              ],
            ),
            Container(
              color: Colors.black,
              child: Center(
                  child: Text(
                "DateTime",
                style: TextStyle(color: Colors.white),
              )),
            )
          ],
        ),
      ),
    );
  }
}
