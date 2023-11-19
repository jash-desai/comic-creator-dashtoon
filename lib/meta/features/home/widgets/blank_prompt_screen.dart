import 'package:flutter/material.dart';

import '../../../../core/globals/dimensions_globals.dart';
import '../../../../core/globals/fonts_globals.dart';

// blank input query form
class BlankInputQueryScreen extends StatelessWidget {
  const BlankInputQueryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Choose a Panel and begin!",
        style: Fonts.light
            .setColor(Colors.white)
            .letterSpace(0.9)
            .size(DeviceDimension.textScaleFactor * 15),
      ),
    );
  }
}
