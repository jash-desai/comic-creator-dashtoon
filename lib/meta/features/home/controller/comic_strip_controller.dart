import 'comic_panel_controller.dart';
import '../widgets/comic_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final comicStripControllerProvider =
    StateNotifierProvider<ComicStripController, ConsumerWidget>(
  (ref) => ComicStripController(),
);

class ComicStripController extends StateNotifier<ConsumerWidget> {
  ComicStripController() : super(const ComicStrip());
  ConsumerWidget get getState => state;
  // provider functions to implement scroll
  void scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  void scrollToTop() {
    _scrollController.animateTo(
      _scrollController.position.minScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }
}

final ScrollController _scrollController = ScrollController();

// comic strip is a list view of multiple individual comic panels
class ComicStrip extends ConsumerWidget {
  const ComicStrip({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comicFrames = ref.watch(comicPanelControllerProvider);
    return Padding(
      padding: const EdgeInsets.all(0),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: comicFrames.length,
        itemBuilder: (BuildContext context, int index) {
          return ComicPanel(image: comicFrames[index], index: index);
        },
      ),
    );
  }
}
