import 'package:flutter/material.dart';
class Constant{
  static const String apiUrl = 'http://api.maccms.bteee.com/api.php/';
  static SlideTransition createTransition(
  Animation<double> animation, Widget child) {
    return new SlideTransition(
        position: new Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: const Offset(0.0, 0.0),
    ).animate(animation),
        child: child,
    );
  }
  static const version = '0.0.1.1';
  static const logoImg = 'images/index_discovery_logo2.png';
  static const name = '萌新影视';
}