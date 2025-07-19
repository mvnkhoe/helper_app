import 'package:flutter/material.dart';

// Custom Clipper for the bottom curve
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, 0);
    path.quadraticBezierTo(size.width * 0.25, 30, size.width * 0.5, 0);
    path.quadraticBezierTo(size.width * 0.75, -30, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
