import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/api_providers.dart';
import '../../../../core/utils.dart';
import 'comic_panel_controller.dart';

// provider controller for input query
final inputQueryController = StateNotifierProvider<InputQueryController, bool>(
  (ref) {
    final api = ref.read(apiProvider);
    final comicPanelController =
        ref.read(comicPanelControllerProvider.notifier);
    return InputQueryController(
      apiProvider: api,
      comicPanelControllerProvider: comicPanelController,
      ref: ref,
    );
  },
);

final isInputEnabled = StateProvider<int>((ref) => -1);

class InputQueryController extends StateNotifier<bool> {
  final APIProvider _apiProvider;
  final ComicPanelController _homeControllerProvider;
  final Ref _ref;
  InputQueryController({
    required APIProvider apiProvider,
    required ComicPanelController comicPanelControllerProvider,
    required Ref ref,
  })  : _apiProvider = apiProvider,
        _homeControllerProvider = comicPanelControllerProvider,
        _ref = ref,
        super(false);

  void genPanel(String query) async {
    state = true;
    final res = await _apiProvider.generatePanel(query, true);
    res.fold((l) => showToast(l.message), (r) {
      _homeControllerProvider.updatePanel(r, _ref.read(isInputEnabled));
    });
    state = false;
  }
}
