// ignore_for_file: deprecated_member_use

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/globals/colors_globals.dart';
import '../../../../core/globals/fonts_globals.dart';
import '../../../../core/globals/spaces_globals.dart';
import '../../../../core/utils.dart';
import '../controller/comic_panel_controller.dart';
import '../controller/query_controller.dart';

// comic panel is individual comic frame
class ComicPanel extends ConsumerWidget {
  const ComicPanel({
    super.key,
    required this.image,
    required this.index,
  });
  final Uint8List image;
  final int index;

  // function to activate the input query form
  void activateInputQueryForm(WidgetRef ref) {
    if (ref.read(inputQueryController)) {
      showToast("Please wait for current process to finish");
      return;
    }
    ref.read(isInputEnabled.notifier).update((state) => index);
  }

// calling delete panel function through provider
  void deleteImage(WidgetRef ref) {
    ref.read(isInputEnabled.notifier).update((state) {
      if (state >= 0) {
        return ref.read(isInputEnabled) - 1;
      } else {
        return state;
      }
    });
    ref.read(comicPanelControllerProvider.notifier).deletePanel(index);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${index + 1} : ",
              style: Fonts.bold.size(20),
            ),
            Spaces.horzGapInBetween,
            Image.memory(
              image,
            ),
            Spaces.horzGapInBetween,
            Column(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).canvasColor,
                  child: IconButton(
                    icon: const Icon(
                      Icons.edit,
                      color: iconColor,
                    ),
                    onPressed: () => activateInputQueryForm(ref),
                  ),
                ),
                Spaces.vertGapInBetween,
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Theme.of(context).errorColor,
                  child: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: kWhite,
                    ),
                    onPressed: () => deleteImage(ref),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
