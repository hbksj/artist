import 'package:artist/screens/Profile.dart';
import 'package:artist/screens/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:circular_reveal_animation/circular_reveal_animation.dart';
import 'package:artist/screens/HomeContent.dart';
class NavigationScreen extends StatefulWidget {
  final int _index;

  NavigationScreen(this._index) : super();

  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> animation;
  User ?user=FirebaseAuth.instance.currentUser;

  @override
  void didUpdateWidget(NavigationScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget._index != widget._index) {
      _startAnimation();
    }
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();

    super.initState();
  }

  _startAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );
    animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Center(
        child: CircularRevealAnimation(
        animation: animation,
        centerOffset: Offset(80, 80),
    maxRadius: MediaQuery.of(context).size.longestSide * 1.1,
    child:  widget._index==0?homePage():widget._index==4?Profile():Container(child: Center(child: Text("Work In Progress"),)

        ))));
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF' + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }
}