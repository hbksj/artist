import 'package:artist/assets/icon/rsicon.dart';
import 'package:artist/screens/loginPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class newUser extends StatefulWidget {
  const newUser({Key? key}) : super(key: key);

  @override
  State<newUser> createState() => _newUserState();
}

class _newUserState extends State<newUser> {
  TextEditingController _fnameController = TextEditingController();
  TextEditingController _lnameController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _pinController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _minbudgetController = TextEditingController();
  TextEditingController _maxbudgetController = TextEditingController();
  String dropdownValue = "Andhra Pradesh";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Stack(
          children: [
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 500.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: TextField(
                        controller: _fnameController,
                        style: GoogleFonts.merriweather(color: Colors.white),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.ubuntu(color: Colors.white),
                            icon: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 65.h,
                            ),
                            hintText: "Enter First Name")),
                  ),
                  SizedBox(height: 50.h),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: TextField(
                        controller: _lnameController,
                        style: GoogleFonts.merriweather(color: Colors.white),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.ubuntu(color: Colors.white),
                            icon: Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 65.h,
                            ),
                            hintText: "Enter Last Name")),
                  ),
                  SizedBox(height: 50.h),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: TextField(
                        controller: _addressController,
                        style: GoogleFonts.merriweather(color: Colors.white),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: GoogleFonts.ubuntu(color: Colors.white),
                            icon: Icon(
                              FontAwesomeIcons.addressCard,
                              size: 65.h,
                              color: Colors.white,
                            ),
                            hintText: "Enter Address")),
                  ),
                  SizedBox(height: 50.h),
                  Row(
                    children: [
                      Container(
                        width: 400.w,
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: TextField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(6)
                            ],
                            controller: _pinController,
                            style:
                                GoogleFonts.merriweather(color: Colors.white),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle:
                                    GoogleFonts.ubuntu(color: Colors.white),
                                icon: Icon(
                                  FontAwesomeIcons.addressCard,
                                  size: 65.h,
                                  color: Colors.white,
                                ),
                                hintText: "Pincode")),
                      ),
                      SizedBox(
                        width: 100.w,
                      ),
                      Container(
                        width: 400.w,
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: TextField(
                            controller: _cityController,
                            style:
                                GoogleFonts.merriweather(color: Colors.white),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle:
                                    GoogleFonts.ubuntu(color: Colors.white),
                                icon: Icon(
                                  FontAwesomeIcons.addressCard,
                                  size: 65.h,
                                  color: Colors.white,
                                ),
                                hintText: "City")),
                      ),
                    ],
                  ),
                  SizedBox(height: 50.h),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      padding: EdgeInsets.only(left: 20.w, right: 20.w),
                      child: DropdownButton<String>(
                        value: dropdownValue,
                        icon: const Icon(Icons.keyboard_arrow_down_sharp),
                        elevation: 16,
                        style: TextStyle(color: Colors.white, fontSize: 55.sp),
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownValue = newValue!;
                            print(dropdownValue);
                          });
                        },
                        items: <String>[
                          "Andhra Pradesh",
                          "Arunachal Pradesh",
                          "Assam",
                          "Bihar",
                          "Chhattisgarh",
                          "Goa",
                          "Gujarat",
                          "Haryana",
                          "Himachal Pradesh",
                          "Jammu and Kashmir",
                          "Jharkhand",
                          "Karnataka",
                          "Kerala",
                          "Madhya Pradesh",
                          "Maharashtra",
                          "Manipur",
                          "Meghalaya",
                          "Mizoram",
                          "Nagaland",
                          "Odisha",
                          "Punjab",
                          "Rajasthan",
                          "Sikkim",
                          "Tamil Nadu",
                          "Telangana",
                          "Tripura",
                          "Uttar Pradesh",
                          "Uttarakhand",
                          "West Bengal"
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )),
                  SizedBox(
                    height: 50.h,
                  ),
                  Text(
                    "Budget",
                    style: GoogleFonts.ubuntu(
                        fontSize: 55.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 400.w,
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _minbudgetController,
                            style:
                                GoogleFonts.merriweather(color: Colors.white),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle:
                                    GoogleFonts.ubuntu(color: Colors.white),
                                icon: Icon(
                                  RsIcon.rsicon,
                                  size: 65.h,
                                  color: Colors.white,
                                ),
                                hintText: "Min Budget")),
                      ),
                      SizedBox(
                        width: 50.w,
                      ),
                      Container(
                        width: 400.w,
                        decoration: BoxDecoration(
                            color: Colors.black26,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        padding: EdgeInsets.only(left: 20.w, right: 20.w),
                        child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _maxbudgetController,
                            style:
                                GoogleFonts.merriweather(color: Colors.white),
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintStyle:
                                    GoogleFonts.ubuntu(color: Colors.white),
                                icon: Icon(
                                  RsIcon.rsicon,
                                  size: 65.h,
                                  color: Colors.white,
                                ),
                                hintText: "Max Budget")),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 150.h,
                  ),
                  GestureDetector(
                      onTap: () {
                        _fnameController.text == "" ||
                                _lnameController.text == "" ||
                                _addressController.text == "" ||
                                _pinController.text == "" ||
                                _cityController.text == "" ||
                                _minbudgetController.text == "" ||
                                _maxbudgetController.text == ""
                            ? Fluttertoast.showToast(msg: "Fill all the fields")
                            : _pinController.text.length < 6
                                ? Fluttertoast.showToast(
                                    msg: "Enter a valid pincode")
                                : FirebaseAuth.instance.currentUser?.uid != null
                                    ? FirebaseFirestore.instance
                                        .collection("Artist")
                                        .doc(
                                            "${FirebaseAuth.instance.currentUser?.uid}")
                                        .set({
                                        'uid': FirebaseAuth
                                            .instance.currentUser?.uid,
                                        'name': _fnameController.text +
                                            " " +
                                            _lnameController.text,
                                        'address': _addressController.text,
                                        'pin_code': _pinController.text,
                                        'city': _cityController.text,
                                        'state': dropdownValue.toString(),
                                        'min_budget': _minbudgetController.text,
                                        'max_budget': _maxbudgetController.text
                                      }).whenComplete(() => FirebaseAuth
                                            .instance.currentUser
                                            ?.updateDisplayName(
                                                _fnameController.text +
                                                    " " +
                                                    _lnameController.text))
                                    : Fluttertoast.showToast(
                                        msg: "Login Error");
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular((20))),
                        height: 100.h,
                        width: 500.h,
                        child: Center(child: Text("Continue")),

                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                  GestureDetector(
                      onTap: () => Get.off(LoginPage()),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.black45,
                            borderRadius: BorderRadius.circular((20))),
                        height: 100.h,
                        width: 350.w,
                        child: Center(child: Text("Login")),
                      ))
                ],
              ),
            ),
          ],
        )));
  }
}
