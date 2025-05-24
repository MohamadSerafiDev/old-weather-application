import 'dart:ui';
import 'package:bloc_2/wether%20app/componants/customgradient.dart';
import 'package:flutter/material.dart';

Card customcard(
    int first,
    int middle,
    int last,
    MaterialColor color,
    Alignment start,
    Alignment end,
    double w,
    double hmargin,
    double vmargin,
    Widget child) {
  return Card(
    elevation: 7,
    margin: EdgeInsets.symmetric(horizontal: hmargin, vertical: vmargin),
    shadowColor: Colors.grey[900],
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40),
    ),
    child: Container(
      width: w,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          gradient: customgradient(first, middle, last, color, start, end)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(40),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
          child: child,
        ),
      ),
    ),
  );
}
