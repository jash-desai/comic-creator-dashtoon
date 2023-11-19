import 'package:comic_creator_dashtoon/core/globals/functions_globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/globals/dimensions_globals.dart';

// arrow button shared widget
class CustomButton extends ConsumerWidget {
  const CustomButton({
    required this.icon,
    required this.isBottom,
    super.key,
  });
  final bool isBottom;
  final IconData icon;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: ElevatedButton(
        onPressed: () => (isBottom) ? scrollToBottom(ref) : scrollToTop(ref),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
        ),
        child: Padding(
          padding: EdgeInsets.all(DeviceDimension.horzBlockSize * 0.75),
          child: Icon(
            icon,
            size: (DeviceDimension.horzBlockSize * 1.75),
          ),
        ),
      ),
    );
  }
}
