// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Cliptest extends StatelessWidget {
  const Cliptest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
      ),
      body: ClipPath(
        clipper: TestClipper(),
        child: Container(
          width: double.infinity,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}

class TestClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..lineTo(0, size.height)
      ..quadraticBezierTo(
          size.width / 4, size.height - 40, size.width / 2, size.height - 20)
      ..quadraticBezierTo(
          3 / 4 * size.width, size.height, size.width, size.height - 40)
      ..lineTo(size.width, 0);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
