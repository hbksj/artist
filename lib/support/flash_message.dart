import 'package:flash/flash.dart';
import 'package:flutter/material.dart';
void showMessage(String message,BuildContext context,{var bgcolor=Colors.green,var txtcolor=Colors.white}) {


  showFlash(
      context: context,
      duration: Duration(seconds: 1),
      builder: (_, controller) {
        return Flash(
          controller: controller,
          position: FlashPosition.bottom,
          alignment: Alignment.bottomCenter,


          backgroundColor: bgcolor,
          child: FlashBar(
            icon: Icon(
              Icons.message,
              size: 30.0,
              color: Colors.white,
            ),
            content: Text(message,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
          ),
        );
      });
}