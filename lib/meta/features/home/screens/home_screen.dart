import 'package:comic_creator_dashtoon/meta/features/home/widgets/arrow_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/globals/colors_globals.dart';
import '../../../../core/globals/dimensions_globals.dart';
import '../../../../core/globals/fonts_globals.dart';
import '../../../../core/globals/functions_globals.dart';
import '../../../../core/globals/spaces_globals.dart';
import '../../../../core/utils.dart';
import '../controller/comic_strip_controller.dart';
import '../controller/comic_panel_controller.dart';
import '../widgets/input_query.dart';
import '../widgets/save_dialog.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});
  final queryTextController = TextEditingController();

  // creating a blank comic panel
  bool createComicPanel(WidgetRef ref) {
    if (ref.read(comicPanelControllerProvider).length == 10) {
      showToast("Max 10 panels allowed");
      return false;
    }
    final comicPanelController =
        ref.read(comicPanelControllerProvider.notifier);
    comicPanelController.insertPanel();
    return true;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DeviceDimension().init(context);
    final comicFrames = ref.watch(comicPanelControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "AI Comic Creator by Dashtoon API",
          style: Fonts.medium
              .setColor(textColor)
              .size(DeviceDimension.textScaleFactor * 20),
        ),
        titleSpacing: DeviceDimension.horzBlockSize * 2,
        shadowColor: kWhite.withOpacity(0.5),
      ),
      body: DeviceDimension.screenWidth > 675
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Comic Panel : ${comicFrames.length}",
                      softWrap: true,
                      overflow: TextOverflow.clip,
                      style: Fonts.bold
                          .setColor(textColor)
                          .size(DeviceDimension.textScaleFactor * 16),
                    ),
                    Spaces.vertGapInBetween,
                    Spaces.vertGapInBetween,
                    Spaces.vertGapInBetween,

                    // button to create
                    FloatingActionButton(
                      heroTag: "create",
                      child: const Icon(Icons.generating_tokens_sharp),
                      onPressed: () async {
                        bool flag = createComicPanel(ref);
                        // if (flag) scrollToBottom(ref);
                      },
                    ),
                    Spaces.vertGapInBetween,
                    // button to export
                    FloatingActionButton(
                      heroTag: "save",
                      child: const Icon(Icons.save_rounded),
                      onPressed: () async {
                        int totalPanels = comicFrames.length;
                        if (totalPanels <= 0) {
                          showToast("Create a panel to begin");
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const CustomDialogBox();
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
                // ListView for comic strip
                SizedBox(
                  width: DeviceDimension.horzBlockSize * 50,
                  // late double wdth;
                  // if (comicFrames.length > 1) {
                  // wdth = DeviceDimension.horzBlockSize * 55;
                  // } else {
                  // wdth = DeviceDimension.horzBlockSize * 65;
                  // }
                  child: ref.read(comicStripControllerProvider),
                ),
                if (comicFrames.length > 1)
                  // scroll up and scroll down buttons
                  SizedBox(
                    width: DeviceDimension.horzBlockSize * 5,
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          icon: Icons.arrow_upward_rounded,
                          isBottom: false,
                        ),
                        CustomButton(
                          icon: Icons.arrow_downward_rounded,
                          isBottom: true,
                        ),
                      ],
                    ),
                  ),
                // side input form to take input query
                SizedBox(
                  width: DeviceDimension.horzBlockSize * 30,
                  child: Padding(
                    padding: EdgeInsets.all(DeviceDimension.horzBlockSize),
                    child: InputQueryForm(),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                SizedBox(
                  height: DeviceDimension.vertBlockSize * 35,
                  child: Padding(
                    padding: EdgeInsets.all(DeviceDimension.horzBlockSize),
                    child: InputQueryForm(),
                  ),
                ),
                Spaces.vertGapInBetween,
                SizedBox(
                  height: DeviceDimension.vertBlockSize * 50,
                  child: ref.read(comicStripControllerProvider),
                ),
                Spaces.vertGapInBetween,
              ],
            ),
      floatingActionButton: DeviceDimension.screenWidth < 675
          ? Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: DeviceDimension.horzBlockSize * 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // button to create
                  FloatingActionButton(
                    heroTag: "create",
                    child: const Icon(Icons.generating_tokens_sharp),
                    onPressed: () async {
                      bool flag = createComicPanel(ref);
                      // if (flag) scrollToBottom(ref);
                    },
                  ),
                  Spaces.horzGapInBetween,
                  SizedBox(
                    height: DeviceDimension.vertBlockSize * 5,
                    child: Text(
                      "Comic Panel : ${comicFrames.length}",
                      softWrap: true,
                      overflow: TextOverflow.clip,
                      style: Fonts.bold
                          .setColor(textColor)
                          .size(DeviceDimension.textScaleFactor * 16),
                    ),
                  ),
                  Spaces.horzGapInBetween,
                  // button to export
                  FloatingActionButton(
                    heroTag: "save",
                    child: const Icon(Icons.save_rounded),
                    onPressed: () async {
                      int totalPanels = comicFrames.length;
                      if (totalPanels <= 0) {
                        showToast("Create a panel to begin");
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return const CustomDialogBox();
                          },
                        );
                      }
                    },
                  )
                ],
              ),
            )
          : null,
    );
  }
}
