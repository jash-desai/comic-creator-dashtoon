import 'package:flutter/material.dart';

// vertical and horizontal spaces of sizedBox
class Spaces {
  //vertical gaps
  static const Widget vertSmallestGapInBetween = SizedBox(height: 6);
  static const Widget vertGapInBetween = SizedBox(height: 15);
  static const Widget vertSmallGapInBetween = SizedBox(height: 25);
  static const Widget vertMediumGapInBetween = SizedBox(height: 30);
  static const Widget vertLargeGapInBetween = SizedBox(height: 40);
  static const Widget vertLargestGapInBetween = SizedBox(height: 60);

  //horizontal gaps
  static const Widget horzSmallestGapInBetween = SizedBox(width: 6);
  static const Widget horzGapInBetween = SizedBox(width: 12);
  static const Widget horzSmallGapInBetween = SizedBox(width: 20);
  static const Widget horzMediumGapInBetween = SizedBox(width: 30);
  static const Widget horzLargeGapInBetween = SizedBox(width: 40);
}
