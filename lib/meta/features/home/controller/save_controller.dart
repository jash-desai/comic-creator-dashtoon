import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:image_downloader_web/image_downloader_web.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../core/failure.dart';
import '../../../../core/globals/colors_globals.dart';
import '../../../../core/globals/dimensions_globals.dart';
import '../../../../core/type_defs.dart';
import '../../../../core/utils.dart';
import 'comic_panel_controller.dart';

final saveController = Provider((ref) {
  return SaveController(ref: ref);
});

// provider controller for handling save and export functionalities
class SaveController {
  final Ref _ref;
  SaveController({required Ref ref}) : _ref = ref;

  Future<void> downloadImage(ScreenshotController screenshotController,
      BuildContext context, int rows, int cols, double height) async {
    final res =
        await _genImage(screenshotController, context, rows, cols, height);

    Uint8List? image;
    res.fold(
      (l) {
        showToast("Error downloading image. Please try again!");
        return;
      },
      (r) => image = r,
    );
    // export from byte array
    await WebImageDownloader.downloadImageFromUInt8List(
      uInt8List: image!,
      name: "Comic.png",
    );
  }

  // saving uint8list to normal image format
  FutureEither<Uint8List> _genImage(ScreenshotController screenshotController,
      BuildContext context, int rows, int cols, double height) async {
    try {
      final res = await screenshotController.captureFromLongWidget(
        InheritedTheme.captureAll(
          context,
          Material(
            color: kWhite,
            child: _genComicStrip(rows, cols, height),
          ),
        ),
        delay: const Duration(milliseconds: 100),
        context: context,
      );

      return right(res);
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

// generating a comic strip from individual comic panels
  Widget _genComicStrip(int rows, int cols, double height) {
    final comicFrames = _ref.read(comicPanelControllerProvider);
    int totalCnt = comicFrames.length;
    final EdgeInsets spaces = EdgeInsets.symmetric(
      vertical: height / (DeviceDimension.vertBlockSize * 6),
      horizontal: height / (DeviceDimension.horzBlockSize * 4),
    );
    return Builder(builder: (context) {
      return Padding(
        padding: spaces,
        child: Row(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (int i = 0; i < rows; i++)
                  Row(
                    children: [
                      for (int j = 0;
                          j < cols && (i * cols + j) < totalCnt;
                          j++)
                        Container(
                          margin: spaces,
                          padding: spaces,
                          height: height,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: kBlack,
                              width: 3,
                            ),
                          ),
                          child: Image.memory(
                            comicFrames[(i * cols) + j],
                            fit: BoxFit.contain,
                            height: height,
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
