import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:folding_cell/folding_cell.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';


class Enquiry extends StatefulWidget {
  @override
  _EnquiryState createState() => _EnquiryState();
}

class _EnquiryState extends State<Enquiry> {
  FirebaseAuth auth = FirebaseAuth.instance;
  bool _enabled=true;
  @override
  void initState() {

    EasyLoading.show();
    Future.delayed(Duration(milliseconds: 750),(){setState(() {
      _enabled=false;
    });});
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    Widget _buildFrontWidget(int index, DocumentSnapshot ds) {
      var queryStatus =
      'Success' ;
      var queryColor =
       true ? Colors.green : Colors.red;
      DateTime dateTime = ds['time'].toDate();
      return Builder(builder: (context) {
        return InkWell(
            onTap: () {},
            child: Card(
              color: Color(0xffDEDDE2),
              elevation: 10,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    child: SizedBox.fromSize(
                        size: const Size(40, 40),
                        child: ClipOval(
                            child: Image.asset(
                              'lib/assets/logo/logo.png',
                              fit: BoxFit.fill,
                            ))),
                    alignment: Alignment.centerLeft,
                  ),
                  Align(
                    child: AutoSizeText(
                      queryStatus,
                      style: TextStyle(
                          color: queryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 45.sp),
                    ),
                    alignment: Alignment.centerRight,
                  ),
                  Align(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            'Title:${ds['title']}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo,
                                fontSize: 45.sp),
                            overflow: TextOverflow.ellipsis,
                          ),
                          AutoSizeText(
                            'Date:${dateTime.day}.${dateTime.month}.${dateTime.year}',
                            style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold,
                                fontSize: 45.sp),
                            overflow: TextOverflow.ellipsis,
                          ),
                          AutoSizeText(
                            ds.id,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo,
                                fontSize: 45.sp),
                            overflow: TextOverflow.ellipsis,
                          ),
                          RaisedButton(
                              onPressed: () {
                                final foldingCellState =
                                context.findAncestorStateOfType<
                                    SimpleFoldingCellState>();
                                foldingCellState?.toggleFold();
                              },
                              child: Text(
                                "Check Response",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 45.sp),
                              ),
                              color: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ))
                        ],
                      ),
                      alignment: Alignment.center)
                ],
              ).paddingAll(12),
            ));
      });
    }



    Widget _buildInnerWidget(int index, DocumentSnapshot ds) {

      return Builder(builder: (context) {
        return InkWell(
          onTap: () {
            final foldingCellState =
            context.findAncestorStateOfType<SimpleFoldingCellState>();
            foldingCellState?.toggleFold();
          },
          child: Card(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: AutoSizeText(
                'No Response Yet.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 45.sp),textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      });
    }

    var user = auth.currentUser;
    return Scaffold(
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(190.h),
              child: AppBar(
                backgroundColor: Colors.black,
                title: Text(
                  "Enquiries",
                  style: GoogleFonts.ubuntu(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Get.back(),
                ),

              )),
          body: SingleChildScrollView(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Artist')
                  .doc(user?.uid)
                  .collection('Enquiry')
                  .orderBy('time', descending: true)
                  .limit(10)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                EasyLoading.dismiss();
                if (snapshot.data?.size == 0)
                  return Container(
                      height: MediaQuery.of(context).size.height,
                      child: Center(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.error_outline_rounded,
                                  color: Colors.grey,
                                  size: 40,
                                ),
                                AutoSizeText(
                                  'You have no queries.',
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 45.sp),
                                )
                              ])));
                else {
                  return _enabled==true?Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.black12,
                      enabled: true,
                      child:Column(children: [
                        Card(color: Colors.grey[300],
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20
                                )),
                            child: Container(height: 450.h,width:Get.width,)).paddingOnly(left: 8.w,right: 8.w,top: 16.w,bottom: 16.w),
                        Card(color: Colors.grey[300],
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20
                                )),
                            child: Container(height: 450.h,width:Get.width
                            )).paddingOnly(left: 8.w,right: 8.w,top: 16.w,bottom: 16.w),Card(color: Colors.grey[300],
                            elevation: 5.0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20
                                )),
                            child: Container(height: 450.h,width:Get.width,)).paddingOnly(left: 8.w,right: 8.w,top: 16.w,bottom: 16.w),
                      ],)):ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.docs.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        DocumentSnapshot ds = snapshot.data!.docs[index];

                        return SimpleFoldingCell.create(
                            cellSize:
                            Size(MediaQuery.of(context).size.width, 450.h),
                            padding: EdgeInsets.only(
                                left: 8.w,right: 8.w,top: 16.w,bottom: 16.w),
                            animationDuration: Duration(milliseconds: 300),
                            borderRadius: 10,
                            frontWidget: _buildFrontWidget(index, ds),
                            innerWidget: _buildInnerWidget(index, ds));
                      });
                }
              },
            ),
          ),
        );
  }
}