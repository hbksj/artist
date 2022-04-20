import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget lightBack() => Container(
      width: Get.width,
      height: Get.height,
      child: Opacity(
        child: Image.asset(
          "lib/assets/images/login_back.png",
        ),
        opacity: 0.2,
      ),
      color: Color.fromRGBO(210, 247, 240, 1),
    );

Widget colorBack() => Container(
    height: Get.height,
    width: Get.width,
    color: Colors.black,
    child: ClipPath(
      clipper: ProsteBezierCurve(
        position: ClipPosition.bottom,
        list: [
          BezierCurveSection(
            start: Offset(0, 150),
            top: Offset(Get.width / 2, 200),
            end: Offset(Get.width, 150),
          ),
        ],
      ),
      child: Container(
        height: 200.h,
        color: Color.fromRGBO(247, 0, 67, 1),
      ),
    ));

Widget logoHead()=>Container(
    child: Positioned(
      child: Image.asset(
        "lib/assets/logo/logo.png",
      ),
      height: 500.w,
      left: Get.width / 2 - 250.w,
    ));
