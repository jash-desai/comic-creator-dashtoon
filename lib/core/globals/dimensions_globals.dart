// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

// constant device dimensions
class DeviceDimension {
  static late MediaQueryData mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double horzBlockSize;
  static late double vertBlockSize;
  static late double textScaleFactor;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    textScaleFactor = mediaQueryData.textScaleFactor;
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    horzBlockSize = screenWidth / 100;
    vertBlockSize = screenHeight / 100;
  }
}
