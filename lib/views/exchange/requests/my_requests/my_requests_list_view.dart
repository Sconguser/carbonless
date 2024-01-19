import 'package:carbonless_free/providers/controllers/exchange/requests/my_request_list_controller_provider.dart';
import 'package:carbonless_free/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../models/exchange_request_model.dart';
import 'widgets.dart';

class MyRequestsListView extends ConsumerWidget {
  const MyRequestsListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<ExchangeRequest>? requests = ref.watch(myRequestListNotifier);
    return Container(
      padding: standardOuterPadding,
      child: ListView(
        children: [
          for (ExchangeRequest request in sortRequests(requests))
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: RequestTile(
                exchangeRequest: request,
              ),
            ),
        ],
      ),
    );
  }
}

List<ExchangeRequest> sortRequests(List<ExchangeRequest>? requests) {
  if (requests == null || requests.isEmpty) return [];
  requests.sort((a, b) {
    if (a.created_at.compareTo(b.created_at) < 0) {
      return 1;
    } else {
      return -1;
    }
  });
  return requests;
}
