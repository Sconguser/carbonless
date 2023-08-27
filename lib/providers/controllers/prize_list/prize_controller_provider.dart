import 'dart:convert';

import 'package:carbonless/providers/controllers/loaders/view_loading_controller_provider.dart';
import 'package:carbonless/services/http_utils/http_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/prize_model.dart';
import '../../../services/http_utils/request_provider.dart';
import 'package:http/http.dart' as http;

class PrizesNotifier extends StateNotifier<List<Prize>> {
  PrizesNotifier(List<Prize> state, this.ref) : super(state);

  final Ref ref;
  bool _initialized = false;

  void initialize() async {
    if (!_initialized) {
      ref.read(viewLoadingControllerProvider.notifier).viewLoadingOn();
      await _fetchPrizesAndSetState();
      _initialized = true;
      ref.read(viewLoadingControllerProvider.notifier).viewLoadingOff();
    }
  }

  Future<void> obtainPrize(int prizeId) async {
    final updatedPrizes = state.map((prize) {
      if (prize.id == prizeId && prize.state == PRIZE_STATE.NOT_OBTAINED) {
        // return Prize(
        //   id: prize.id,
        //   state: PRIZE_STATE.OBTAINED,
        //   text: prize.text,
        //   price: prize.price,
        // );
      }
      return prize;
    }).toList();

    state = updatedPrizes;
  }

  Future<void> redeemPrize(String prizeId) async {
    final updatedPrizes = state.map((prize) {
      if (prize.id == prizeId && prize.state == PRIZE_STATE.OBTAINED) {
        // prize.copyWith(state: PRIZE_STATE.REDEEMED);
        // return Prize(
        //   id: prize.id,
        //   state: PRIZE_STATE.REDEEMED,
        //   text: prize.text,
        //   price: prize.price,
        // );
      }
      return prize;
    }).toList();

    state = updatedPrizes;
  }

  void setListOfPrizes(List<Prize> prizes) {
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
    List<Prize>? userPrizes = await _fetchUserPrizes();
    if (userPrizes != null) {
      setListOfPrizes(userPrizes);
    }
    List<Prize>? prizes = await _fetchPrizes();
    if (prizes != null) {
      addListNoDoubles(prizes);
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

  Future<List<Prize>?> _fetchUserPrizes() async {
    try {
      http.Response response = await ref
          .read(httpServiceProvider)
          .executeHttp(RequestType.GET, null, null, Endpoint.USER_PRIZES);
      List<Prize> prizeList = [];
      Map<String, dynamic> decodedList = jsonDecode(response.body);
      for (dynamic prize in decodedList["records"]) {
        Prize jsonPrize = Prize.fromJson(prize);
        if (prize['active'] == true) {
          jsonPrize.copyWith(state: PRIZE_STATE.OBTAINED);
        } else {
          jsonPrize.copyWith(state: PRIZE_STATE.REDEEMED);
        }
        prizeList.add(jsonPrize);
      }
      return prizeList;
    } catch (e) {
      print(e);
    }
    return null;
  }
}

final prizesProvider =
    StateNotifierProvider<PrizesNotifier, List<Prize>>((ref) {
  List<Prize>? prizes = [];

  return PrizesNotifier(prizes, ref);
});
