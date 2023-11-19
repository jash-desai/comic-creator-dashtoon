import 'package:comic_creator_dashtoon/meta/features/home/controller/query_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toggle_list/toggle_list.dart';

import '../../../../core/globals/colors_globals.dart';
import '../../../../core/globals/dimensions_globals.dart';
import '../../../../core/globals/fonts_globals.dart';
import '../../../../core/globals/spaces_globals.dart';
import '../../../../core/utils.dart';
import 'blank_prompt_screen.dart';

class InputQueryForm extends ConsumerWidget {
  InputQueryForm({super.key});
  final queryTextController = TextEditingController();
  final speechTextController = TextEditingController();

  void genImage(WidgetRef ref, String prompt) {
    ref.read(inputQueryController.notifier).genPanel(prompt);
  }

// toggle form for input
  ToggleListItem toggleListItem({
    required BuildContext context,
    required String title,
    required int currentPanel,
    required Widget form,
  }) {
    return ToggleListItem(
      isInitiallyExpanded: true,
      title: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: DeviceDimension.horzBlockSize * 2,
          vertical: DeviceDimension.vertBlockSize * 1.5,
        ),
        child: Text(
          title,
          style: Fonts.bold
              .setColor(iconColor)
              .size(DeviceDimension.horzBlockSize * 1.2),
        ),
      ),
      divider: Divider(
        color: Theme.of(context).dividerColor,
        height: 1,
        thickness: 1,
      ),
      // input query widget
      content: Container(
        padding: EdgeInsets.symmetric(
            horizontal: DeviceDimension.horzBlockSize * 2,
            vertical: DeviceDimension.vertBlockSize * 3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(DeviceDimension.horzBlockSize),
          ),
          color: Theme.of(context).canvasColor,
        ),
        child: currentPanel == -1 ? const BlankInputQueryScreen() : form,
      ),
      headerDecoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        borderRadius:
            BorderRadius.all(Radius.circular(DeviceDimension.horzBlockSize)),
      ),
      // isInitiallyExpanded: true,
      expandedHeaderDecoration: BoxDecoration(
        color: Theme.of(context).appBarTheme.backgroundColor,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(DeviceDimension.horzBlockSize),
        ),
      ),
    );
  }

  // text clear in input query
  void clearEntries(WidgetRef ref) {
    queryTextController.clear();
    ref.read(isInputEnabled.notifier).update((state) => -1);
  }

  Widget completeButton(WidgetRef ref) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        decoration: BoxDecoration(
          color: kBlack,
          borderRadius: BorderRadius.circular(10),
        ),
        child: IconButton(
          highlightColor: kBlue,
          onPressed: () => clearEntries(ref),
          icon: const Icon(
            Icons.done,
            color: iconColor,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(inputQueryController);
    final currentIndex = ref.watch(isInputEnabled);
    return ToggleList(
      toggleAnimationDuration: const Duration(milliseconds: 150),
      divider: const SizedBox(height: 10),
      scrollPosition: AutoScrollPosition.begin,
      trailing: Padding(
        padding: EdgeInsets.all(DeviceDimension.horzBlockSize),
        child: const Icon(
          Icons.expand_more,
          color: kWhite,
        ),
      ),
      children: [
        toggleListItem(
          context: context,
          title: "Generate Image",
          currentPanel: currentIndex,
          form: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Comic Panel : ${currentIndex + 1}",
                      softWrap: true,
                      overflow: TextOverflow.clip,
                      style: Fonts.bold
                          .setColor(textColor)
                          .size(DeviceDimension.horzBlockSize * 1.2),
                    ),
                    if (DeviceDimension.screenWidth > 1000) completeButton(ref),
                  ],
                ),
                if (DeviceDimension.screenWidth < 1000) completeButton(ref),
                Spaces.vertGapInBetween,
                Text(
                  "Prompt",
                  style: Fonts.bold.setColor(textColor).size(12),
                ),
                Spaces.vertSmallestGapInBetween,
                TextField(
                  controller: queryTextController,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Add comic description',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: iconColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: iconColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintStyle: Fonts.light
                        .setColor(textColor.withOpacity(0.7))
                        .size(15),
                    fillColor: const Color.fromRGBO(39, 41, 45, 1),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  ),
                ),
                Spaces.vertGapInBetween,
                Text(
                  "Generative Speech Bubble (Experimental)",
                  style: Fonts.bold.setColor(textColor).size(12),
                ),
                Spaces.vertSmallestGapInBetween,
                TextField(
                  controller: speechTextController,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Add speech text',
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: iconColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: iconColor),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintStyle: Fonts.light
                        .setColor(textColor.withOpacity(0.7))
                        .size(15),
                    fillColor: const Color.fromRGBO(39, 41, 45, 1),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                  ),
                ),
                Spaces.vertGapInBetween,
                SizedBox(
                  width: double.infinity,
                  child: isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(39, 41, 45, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onPressed: () {
                            String query = queryTextController.text;
                            String speech = speechTextController.text;
                            String prompt = query;
                            bool flag = true;
                            if (speech.isNotEmpty) {
                              prompt +=
                                  'along with speech bubble having text $speech';
                            }
                            if (prompt.isEmpty) {
                              showToast("Please enter text!");
                              flag = false;
                            }
                            if (flag) genImage(ref, prompt);
                          },
                          child: Text(
                            "Create Panel",
                            style: Fonts.light.setColor(textColor).size(17),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
