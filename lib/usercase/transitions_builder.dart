import 'package:flutter/material.dart';

class TransitionsBuilder {

  static Route createRoute(dynamic pageView) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => pageView,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = const Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;
    
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    
        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}