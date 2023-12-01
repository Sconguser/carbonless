import 'dart:convert';

import '/models/user_prize_model.dart';
import '/providers/controllers/loaders/view_loading_controller_provider.dart';
import '/providers/controllers/loaders/widget_loading_controller_provider.dart';
import '/services/http_utils/http_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/prize_model.dart';
import '../../../services/http_utils/request_provider.dart';
import 'package:http/http.dart' as http;

class PrizesNotifier extends StateNotifier<List<Prize>> {
  PrizesNotifier(List<Prize> state, this.ref) : super(state);

  final Ref ref;
  bool _initialized = false;

  final List<UserPrize> _userPrizeList = [];

  void initialize() async {
    if (!_initialized) {
      ref.read(viewLoadingControllerProvider.notifier).viewLoadingOn();
      await _fetchPrizesAndSetState();
      _updateListOfActivePrizes();
      _initialized = true;
      ref.read(viewLoadingControllerProvider.notifier).viewLoadingOff();
    }
  }

  void _resetState() {
    state = [];
    _initialized = false;
    initialize();
  }

  Future<void> obtainPrize(int prizeId) async {
    ref.read(widgetLoadingControllerProvider.notifier).widgetLoadingOn();
    bool purchaseSuccessful = await _purchasePrize(prizeId);
    ref.read(widgetLoadingControllerProvider.notifier).widgetLoadingOff();
  }

  String redeemPrize(int prizeId) {
    UserPrize userPrize =
        _userPrizeList.firstWhere((prize) => prize.prize_id == prizeId);
    return userPrize.id;
  }

  void _setListOfUserPrizes(List<UserPrize> userPrizes) {
    _userPrizeList.addAll(userPrizes);
  }

  void _setListOfPrizes(List<Prize> prizes) {
    state = prizes;
  }

  void addListOfPrizes(List<Prize> prizes) {
    state.addAll(prizes);
  }

  void addListNoDoubles(List<Prize> prizes) {
    for (Prize newPrize in prizes) {
      if (!state.any((prize) => prize.id == newPrize.id)) {
        state.add(newPrize);
      }
    }
  }

  Future<void> _fetchPrizesAndSetState() async {
    List<UserPrize>? userPrizes = await _fetchUserPrizes();
    if (userPrizes != null) {
      _setListOfUserPrizes(userPrizes);
    }
    List<Prize>? prizes = await _fetchPrizes();
    if (prizes != null) {
      _setListOfPrizes(prizes);
    }
  }

  void _updateListOfActivePrizes() {
    for (UserPrize userPrize in _userPrizeList) {
      final index = state.indexWhere((x) => x.id == userPrize.prize_id);
      if (index != -1) {
        if (userPrize.active) {
          state[index] = state[index].copyWith(state: PRIZE_STATE.OBTAINED);
        } else {
          state[index] = state[index].copyWith(state: PRIZE_STATE.REDEEMED);
        }
      }
    }
  }

  Future<List<Prize>?> _fetchPrizes() async {
    try {
      http.Response response = await ref
          .read(httpServiceProvider)
          .executeHttp(RequestType.GET, null, null, Endpoint.ALL_PRIZES);
      List<Prize> prizeList = [];
      Map<String, dynamic> decodedList = jsonDecode(response.body);
      for (dynamic prize in decodedList["records"]) {
        prizeList.add(Prize.fromJson(prize));
      }
      return prizeList;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<List<UserPrize>?> _fetchUserPrizes() async {
    try {
      http.Response response = await ref
          .read(httpServiceProvider)
          .executeHttp(RequestType.GET, null, null, Endpoint.USER_PRIZES);
      List<UserPrize> userPrizeList = [];
      Map<String, dynamic> decodedList = jsonDecode(response.body);
      for (dynamic userPrize in decodedList["records"]) {
        UserPrize jsonPrize = UserPrize.fromJson(userPrize);
        userPrizeList.add(jsonPrize);
      }
      return userPrizeList;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<bool> _purchasePrize(int id) async {
    try {
      Map<String, dynamic> body = {
        "user_prize": {
          "prize_id": id,
        }
      };
      http.Response response = await ref
          .read(httpServiceProvider)
          .executeHttp(RequestType.POST, body, null, Endpoint.PRIZE_PURCHASE);
      _resetState();
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
}

final prizesProvider =
    StateNotifierProvider<PrizesNotifier, List<Prize>>((ref) {
  List<Prize>? prizes = [];
  return PrizesNotifier(prizes, ref);
});
