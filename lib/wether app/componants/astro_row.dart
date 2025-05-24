// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Row astroRow(String timeNameAndImageName, String astroTime) {
  return Row(
    children: [
      Stack(
        children: [
          Positioned(
            top: 3,
            right: 1,
            child: Image.asset(
              'moon phases/$timeNameAndImageName.png',
              width: 75,
              height: 75,
              color: Colors.black45,
            ),
          ),
          Image.asset(
            'moon phases/$timeNameAndImageName.png',
            width: 75,
            height: 75,
          ),
        ],
      ),
      const Spacer(
        flex: 1,
      ),
      Text(
        '$timeNameAndImageName : ',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      const Spacer(
        flex: 7,
      ),
      Text(astroTime,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
      const Spacer(
        flex: 2,
      )
    ],
  );
}
