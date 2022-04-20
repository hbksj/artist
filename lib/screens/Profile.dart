import 'dart:io';
import 'package:artist/screens/loginPage.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final editNameController = TextEditingController();
  var user = FirebaseAuth.instance.currentUser;
  final picker = ImagePicker();
  late File _image;
  var name, address, pincode, city, state, minBudget, maxBudget, photoUrl,theme;

  Widget editIcon(@required var edit, @required int length,
      {bool isNum = false}) {
    TextEditingController _edit = TextEditingController();
    return IconButton(
        onPressed: () {
          Get.defaultDialog(
              title: "Edit ${edit}",
              content: Container(
                width: 400.w,
                height: 400.w,
                child: Column(
                  children: [
                    TextField(
                      autofocus: true,
                      controller: _edit,
                      textAlign: TextAlign.center,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(length)
                      ],
                      keyboardType: isNum == true
                          ? TextInputType.number
                          : TextInputType.text,
                      decoration:
                          InputDecoration(prefixText: isNum == true ? "₹" : ""),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateColor.resolveWith(
                                (states) => Colors.black45)),
                        onPressed: () async {
                          if (_edit.text.isNotEmpty) {
                            try {
                              EasyLoading.show();
                              FirebaseFirestore.instance
                                  .collection("Artist")
                                  .doc(user?.uid)
                                  .update({"$edit": _edit.text}).whenComplete(
                                      () {
                                getInfo();
                                Get.back();
                                EasyLoading.dismiss();
                                Fluttertoast.showToast(
                                    msg: "Changes successfully applied");
                              });
                            } catch (e) {
                              Fluttertoast.showToast(
                                  msg: "Something went wrong.");
                            }
                          } else {
                            Fluttertoast.showToast(msg: "Enter valid details");
                          }
                        },
                        child: AutoSizeText("Save Changes"))
                  ],
                ),
              ));
        },
        icon: const Icon(
          Icons.edit,
          color: Colors.black45,
        ));
  }

  Widget _info(var name, var value) {
    return Column(
      children: [
        SizedBox(
          height: 20.h,
        ),
        Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            width: 900.w,
            child: Center(
              child: AutoSizeText(
                "$name: ",
                style: GoogleFonts.roboto(
                    color: Colors.black,
                    fontSize: 55.sp,
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.fade,
              ),
            )),
        AutoSizeText(
          "${value ?? "Loading"}",
          style:
              GoogleFonts.merriweather(color: Colors.black87, fontSize: 45.sp),
          overflow: TextOverflow.fade,
        ),
        SizedBox(
          height: 30.h,
        )
      ],
    );
  }

  void getInfo() async {
    var getdata = await FirebaseFirestore.instance
        .collection("Artist")
        .doc(user?.uid)
        .get();
    var data = getdata.data();

    setState(() {
      photoUrl = user?.photoURL.toString();
      name = data?['name'];
      address = data?['address'];
      pincode = data?['pin_code'];
      city = data?['city'];
      state = data?['state'];
      minBudget = data?['min_budget'];
      maxBudget = data?['max_budget'];
    });
  }

  void editProfileImage() {
    showMaterialModalBottomSheet(
        context: context,
        builder: (context) => Container(
              height: 450.h,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.camera_alt).paddingOnly(left: 10),
                            AutoSizeText(
                              'Take a Picture',
                              style: GoogleFonts.ubuntu(color: Colors.black),
                            ).paddingOnly(left: 10),
                          ]),
                      onTap: _takeAndUploadPicture,
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 15.h,
                    ).paddingOnly(left: 10),
                    InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.image).paddingOnly(left: 10),
                            AutoSizeText('Choose from Photos',
                                    style:
                                        GoogleFonts.ubuntu(color: Colors.black))
                                .paddingOnly(left: 10)
                          ],
                        ),
                        onTap: _selectAndUploadPicture)
                  ]),
            ));
  }
  void sharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    theme = "light";
  }

  @override
  void initState() {
    // TODO: implement initState
    sharedPref();
    getInfo();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          children: [theme == "light"
              ? Container(
            width: Get.width,
            height: Get.height,
            child: Opacity(
              child: Image.asset(
                "lib/assets/images/login_back.png",
              ),
              opacity: 0.2,
            ),
            color: Color.fromRGBO(210, 247, 240, 1),
          ):
            Container(
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
                    color: Color.fromRGBO(247, 0, 67 , 1),
                  ),
                )),
            Center(
                child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),


                        GestureDetector(
                          onTap: () {
                            editProfileImage();
                          },
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(photoUrl ??
                                "https://firebasestorage.googleapis.com/v0/b/partyon-5e103.appspot.com/o/assets%2Fprofile.jpg?alt=media&token=ff90d1e7-07a9-4c08-ab44-eed8869718d1"),
                            radius: 150.h,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        AutoSizeText(
                          "Tap on image to edit",
                          style: GoogleFonts.ubuntu(fontSize: 40.sp,color: theme=="light"?Colors.black:Colors.white),
                        ),

                    SizedBox(
                      width: 200.w,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center,children: [

                      SizedBox(width: 150.w,),
                      AutoSizeText("${toBeginningOfSentenceCase(name) ?? "Loading"}",
                          style: GoogleFonts.roboto(
                              color: theme=="light"?Colors.black:Colors.white, fontSize: 80.sp)),
                      SizedBox(
                        width: 20.w,
                      ),
                      editIcon("name", 20),
                    ],),


                SizedBox(
                  height: 200.h,
                ),
                Card(
                    elevation: 10,
                    shadowColor: Colors.white38,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Container(
                        width: 1200.w,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                _info("Address", address),
                                SizedBox(
                                  width: 20.w,
                                ),
                                editIcon("address", 30),
                              ],
                            ),
                            Row(
                              children: [
                                _info("City", city),
                                SizedBox(
                                  width: 20.w,
                                ),
                                editIcon("city", 20),
                              ],
                            ),
                            Row(
                              children: [
                                _info("State", state),
                                SizedBox(
                                  width: 20.w,
                                ),
                                editIcon("state", 20),
                              ],
                            ),
                            Row(
                              children: [
                                _info("Min Budget", minBudget),
                                editIcon("min_budget", 30, isNum: true),
                              ],
                            ),
                            Row(
                              children: [
                                _info("Max Budget", maxBudget),
                                SizedBox(
                                  width: 20.w,
                                ),
                                editIcon("max_budget", 30, isNum: true),
                              ],
                            ),
                          ],
                        ))),
                SizedBox(height: 50.h),
                GestureDetector(
                    onTap: () {
                      try {
                        EasyLoading.show();
                        FirebaseAuth.instance.signOut().whenComplete(() {
                          EasyLoading.dismiss();
                        });
                        Get.off(LoginPage());
                      } catch (e) {
                        Fluttertoast.showToast(msg: "Something went wrong");
                        EasyLoading.dismiss();
                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        height: 125.h,
                        width: Get.width,
                        child: Row(
                          children: [
                            SizedBox(width: 20.w,),
                            Icon(
                              Icons.power_settings_new,
                              color: Colors.black45,
                            ),
                            SizedBox(width: 20.w,),
                            AutoSizeText(
                              "Logout",
                              style: GoogleFonts.ubuntu(
                                  color: Colors.black,
                                  fontSize: 50.sp,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    )).paddingOnly(left: 10.w, right: 10.w)
              ],
            ))
          ],
        ));
  }

  Future _takeProfilePicture() async {
    var pickedFile = await picker.pickImage(
        source: ImageSource.camera, maxHeight: 480, maxWidth: 640);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  Future _selectProfilePicture() async {
    var pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 20);

    setState(() {
      _image = File(pickedFile!.path);
    });
  }

  Future<void> _uploadProfilePicture() async {
    EasyLoading.show();
    // ignore: non_constant_identifier_names
    String? URL;
    final Reference ref = FirebaseStorage.instance
        .ref()
        .child('artist/${user?.uid}/${user?.uid}_profilePicture.jpg');
    final UploadTask uploadTask = ref.putFile(_image);

    // ignore: non_constant_identifier_names
    try {
      await uploadTask.then((TaskSnapShot) async {
        FirebaseAuth.instance.currentUser
            ?.updatePhotoURL(await TaskSnapShot.ref.getDownloadURL())
            .whenComplete(() => EasyLoading.dismiss())
            .whenComplete(() {
          Get.back();
          getInfo();
          Fluttertoast.showToast(msg: 'Profile Picture changed Successfully');
        });
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "An unknown error occured.Please try again");
      print(e);
      EasyLoading.dismiss();
    }
  }

  void _selectAndUploadPicture() async {
    try {
      await _selectProfilePicture();
      await _uploadProfilePicture();
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Something went wrong.',
      );
    }
  }

  void _takeAndUploadPicture() async {
    try {
      await _takeProfilePicture();
      await _uploadProfilePicture();
    } catch (e) {
      Fluttertoast.showToast(
        msg: 'Something went wrong.',
      );
    }
  }
}
