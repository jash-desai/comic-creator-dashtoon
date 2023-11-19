import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/constants/image_constants.dart';

// individual comic panel provider
final comicPanelControllerProvider =
    StateNotifierProvider<ComicPanelController, List<Uint8List>>(
  (ref) => ComicPanelController(),
);

class ComicPanelController extends StateNotifier<List<Uint8List>> {
  ComicPanelController() : super(List.empty(growable: true));

  List<Uint8List> get getState => state;

  // insert, update, delete functions
  void insertPanel() {
    state = [...state, imageBlank];
  }

  void updatePanel(Uint8List image, int currFrameIndex) {
    List<Uint8List> updatedState = List.from(state);
    updatedState[currFrameIndex] = image;
    state = updatedState;
  }

  void deletePanel(int currFrameIndex) {
    List<Uint8List> updatedState = List.from(state);
    updatedState.removeAt(currFrameIndex);
    state = updatedState;
  }
}
