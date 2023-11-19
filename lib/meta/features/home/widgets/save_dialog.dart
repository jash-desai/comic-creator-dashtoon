import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:screenshot/screenshot.dart';

import '../../../../core/globals/colors_globals.dart';
import '../../../../core/globals/dimensions_globals.dart';
import '../../../../core/globals/fonts_globals.dart';
import '../../../../core/globals/spaces_globals.dart';
import '../../../../core/utils.dart';
import '../controller/comic_panel_controller.dart';
import '../controller/save_controller.dart';

class CustomDialogBox extends ConsumerStatefulWidget {
  const CustomDialogBox({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomDialogBoxState();
}

class _CustomDialogBoxState extends ConsumerState<CustomDialogBox> {
  // global variables :
  late int _size, _rows, _cols;
  final _formKey = GlobalKey<FormState>();
  final ScreenshotController screenshotController = ScreenshotController();
  final TextEditingController rowsController = TextEditingController();
  final TextEditingController colsController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();
  final TextEditingController dimController = TextEditingController();

  // saving the inputs
  bool saveForm() {
    if (!_formKey.currentState!.validate()) {
      return false;
    }
    _formKey.currentState!.save();
    return true;
  }

  // download function
  void downloadImage() async {
    if (!saveForm()) return;

    final saveHandler = ref.read(saveController);
    await saveHandler.downloadImage(
      screenshotController,
      context,
      _rows,
      _cols,
      _size.toDouble(),
    );
  }

  // input dialog form
  Widget formInput(String text, TextFormField txtField) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Text(
            "$text : ",
            style: Fonts.bold
                .setColor(textColor)
                .size(DeviceDimension.horzBlockSize * 1.15),
          ),
          Spaces.horzGapInBetween,
          Expanded(
            flex: 1,
            child: txtField,
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    sizeController.text = "512";
    super.initState();
  }

  // maintaining aspect ratio
  String getDimensions(int totalPanels) {
    int? size = int.tryParse(sizeController.text);
    int? col = int.tryParse(colsController.text);
    int? row = int.tryParse(rowsController.text);
    if (size == null ||
        col == null ||
        row == null ||
        col > totalPanels ||
        row > totalPanels) return "";

    int width = ((size * col) +
            (4 * col * (size / (DeviceDimension.horzBlockSize * 4))) +
            2 * (size / (DeviceDimension.horzBlockSize * 4)) +
            3 * 2 * col)
        .toInt();
    int height = ((size * row) +
            (4 * row * (size / (DeviceDimension.vertBlockSize * 6))) +
            2 * (size / (DeviceDimension.vertBlockSize * 6)) +
            3 * 2 * row)
        .toInt();

    return "$width x $height";
  }

  @override
  Widget build(BuildContext context) {
    final totalPanels = ref.read(comicPanelControllerProvider).length;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        // dialog box
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: DeviceDimension.horzBlockSize * 2,
              vertical: DeviceDimension.vertBlockSize * 4,
            ),
            child: Padding(
              padding: EdgeInsets.all(DeviceDimension.horzBlockSize),
              child: SizedBox(
                width: DeviceDimension.horzBlockSize * 20,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "Total Panels : $totalPanels",
                          style: Fonts.medium
                              .setColor(textColor)
                              .size(DeviceDimension.horzBlockSize * 1.15),
                        ),
                      ),
                      Spaces.vertSmallestGapInBetween,
                      formInput(
                        "Image Size (in px)",
                        TextFormField(
                          controller: sizeController,
                          onSaved: (val) {
                            _size = int.parse(val!);
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Size can't be empty";
                            }
                            if (int.tryParse(value) == null) {
                              return "Enter a number";
                            }
                            return null;
                          },
                          onChanged: (val) {
                            dimController.text = getDimensions(totalPanels);
                          },
                          decoration: textboxDecoration("Enter size of image"),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: DeviceDimension.horzBlockSize * 10,
                            child: formInput(
                              "Rows",
                              TextFormField(
                                controller: rowsController,
                                validator: (val) {
                                  if (val == null || int.parse(val) == 0) {
                                    showToast("Rows can't be empty");
                                    return "";
                                  }
                                  if (int.tryParse(val) == null) {
                                    showToast("Enter rows");
                                    return "";
                                  }
                                  if (int.parse(val) > totalPanels) {
                                    showToast("Rows can't exceed frames");
                                    return "";
                                  }
                                  return null;
                                },
                                onSaved: (val) {
                                  _rows = int.parse(val!);
                                },
                                onChanged: (val) {
                                  // handing number of columns based on input
                                  int? newRows = int.tryParse(val);
                                  if (newRows != null) {
                                    if (totalPanels % newRows == 0) {
                                      colsController.text =
                                          ("${totalPanels / newRows}");
                                    } else {
                                      colsController.text =
                                          ("${(totalPanels ~/ newRows) + 1}");
                                    }
                                  }
                                  dimController.text =
                                      getDimensions(totalPanels);
                                },
                                decoration: textboxDecoration(
                                  "",
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: DeviceDimension.horzBlockSize * 10,
                            child: formInput(
                              "Cols",
                              TextFormField(
                                controller: colsController,
                                validator: (val) {
                                  // int? newCol = int.parse(val!);
                                  if (val == null ||
                                      int.parse(val) == 0 ||
                                      int.tryParse(val) == null) {
                                    showToast("Cols can't be empty");
                                    return "";
                                  }
                                  if (int.parse(val) > totalPanels) {
                                    showToast("Cols can't exceed frames");
                                    return "";
                                  }

                                  return null;
                                },
                                onSaved: (val) {
                                  _cols = int.parse(val!);
                                },
                                onChanged: (val) {
                                  // handing number of rows based on input
                                  int? newCol = int.tryParse(val);
                                  if (newCol != null) {
                                    if (totalPanels % newCol == 0) {
                                      rowsController.text =
                                          ("${totalPanels / newCol}");
                                    } else {
                                      rowsController.text =
                                          ("${(totalPanels ~/ newCol) + 1}");
                                    }
                                    dimController.text =
                                        getDimensions(totalPanels);
                                  }
                                },
                                decoration: textboxDecoration(
                                  "",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spaces.vertGapInBetween,
                      formInput(
                        "Panel Dimensions (in px)",
                        TextFormField(
                          controller: dimController,
                          enabled: false,
                        ),
                      ),
                      Spaces.vertGapInBetween,
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            backgroundColor: Colors.black54,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onPressed: downloadImage,
                          child: Text(
                            "Export Comic",
                            style: Fonts.medium.setColor(textColor).size(17),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
