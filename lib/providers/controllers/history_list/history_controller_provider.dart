import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/auth_repository.dart';
import '../../../models/history_model.dart';
import '../../../services/http_utils/http_service.dart';
import '../../../services/http_utils/request_provider.dart';
import '../loaders/view_loading_controller_provider.dart';
import 'package:http/http.dart' as http;

class HistoryNotifier extends StateNotifier<List<History>> {
  HistoryNotifier(List<History> state, this.ref) : super(state);
  final Ref ref;

  bool _initialized = false;

  void initialize() async {
    if (!_initialized) {
      ref.read(viewLoadingControllerProvider.notifier).viewLoadingOn();
      await _getHistories();
      _initialized = true;
      ref.read(viewLoadingControllerProvider.notifier).viewLoadingOff();
    }
  }

  Future<void> _getHistories() async {
    http.Response response = await ref.read(httpServiceProvider).executeHttp(
          RequestType.GET,
          null,
          null,
          Endpoint.HISTORY,
          ref.read(authRepositoryProvider).getToken(),
        );

    List<dynamic> decodedList = jsonDecode(response.body);
    // ref.read(historyNotifier.notifier).setListOfHistoriesFromJson(decodedList);
    setListOfHistoriesFromJson(decodedList);
  }

  void setListOfHistoriesFromJson(List<dynamic> histories) {
    List<History> historyList = [];
    for (dynamic history in histories) {
      historyList.add(History.fromJson(history));
    }
    state = historyList;
  }
}

final historyNotifier =
    StateNotifierProvider<HistoryNotifier, List<History>>((ref) {
  List<History>? histories = [];
  return HistoryNotifier(histories, ref);
});
