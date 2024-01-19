import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/exchange_request_model.dart';
import '../../loaders/view_loading_controller_provider.dart';

class MyRequestListNotifier extends StateNotifier<List<ExchangeRequest>> {
  MyRequestListNotifier(List<ExchangeRequest> initialState, this.ref)
      : super(initialState);
  final Ref ref;
  bool _initialized = false;

  void initialize() async {
    if (_initialized) {
      return;
    }
    ref.read(viewLoadingControllerProvider.notifier).viewLoadingOn();
    await _getMyRequests();
    _initialized = true;
    ref.read(viewLoadingControllerProvider.notifier).viewLoadingOff();
  }

  Future<void> _getMyRequests() async {
    await Future.delayed(const Duration(milliseconds: 2000));
    _setListOfRequestsFromJson([]);
  }

  void _setListOfRequestsFromJson(List<dynamic> requests) {
    List<ExchangeRequest> requests = [
      ExchangeRequest(
        id: 0,
        username: 'Mioszek',
        body: 'Siema chętnie wymienię się za buty stary patrz jakie ty',
        created_at: DateTime(2023, 6, 13),
      ),
      ExchangeRequest(
        id: 1,
        username: 'Mioszek',
        body: 'Siema chętnie wymienię się za buty stary patrz jakie ty',
        created_at: DateTime(2023, 7, 13),
      ),
      ExchangeRequest(
        id: 2,
        username: 'Mioszek',
        body: 'Siema chętnie wymienię się za buty stary patrz jakie ty',
        created_at: DateTime(2023, 9, 13),
      ),
      ExchangeRequest(
        id: 3,
        username: 'Mioszek',
        body: 'Siema chętnie wymienię się za buty stary patrz jakie ty',
        created_at: DateTime(2023, 12, 13),
      ),
      ExchangeRequest(
        id: 4,
        username: 'Mioszek',
        body: 'Siema chętnie wymienię się za buty stary patrz jakie ty',
        created_at: DateTime(2023, 11, 13),
      ),
    ];
    state = requests;
  }
}

final myRequestListNotifier =
    StateNotifierProvider<MyRequestListNotifier, List<ExchangeRequest>>((ref) {
  return MyRequestListNotifier([], ref);
});
