import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../meta/features/home/controller/comic_strip_controller.dart';

// scroll functions declared globally
void scrollToBottom(WidgetRef ref) {
  final editorController = ref.read(comicStripControllerProvider.notifier);
  editorController.scrollToBottom();
  // return true;
}

void scrollToTop(WidgetRef ref) {
  final editorController = ref.read(comicStripControllerProvider.notifier);
  editorController.scrollToTop();
  // return true;
}
