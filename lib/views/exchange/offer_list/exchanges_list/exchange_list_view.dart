import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../localization/messages.i18n.dart';
import '../../../../main.dart';
import '../../../../models/exchange_offer_model.dart';
import '../../../../providers/controllers/exchange/exchange_list_controller_provider.dart';
import '../../../../shared/constants.dart';
import '../widgets.dart';

class ExchangeListView extends ConsumerWidget {
  const ExchangeListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    List<ExchangeOffer>? offers = ref.watch(exchangeOfferListNotifier);

    return Container(
      padding: standardOuterPadding,
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (ExchangeOffer offer in offers!)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: ExchangeTile(
                offer: offer,
              ),
            )
        ],
      ),
    );
  }

  void sortOffers(List<ExchangeOffer>? offers) {
    if (offers == null || offers.isEmpty) return;
    offers.sort((a, b) {
      if (a.created_at.compareTo(b.created_at) < 0) {
        return 1;
      } else {
        return -1;
      }
    });
  }
}
