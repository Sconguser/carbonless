import 'package:carbonless_free/main.dart';
import 'package:carbonless_free/views/exchange/offer/make_offer_view.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

import '../../../localization/messages.i18n.dart';
import '../../../models/exchange_offer_model.dart';
import '../../../shared/bottom_nav_bar.dart';

class ExchangeDetailsView extends ConsumerWidget {
  final ExchangeOffer offer;
  ExchangeDetailsView({Key? key, required this.offer}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    return BottomNavigationBarView(
      scaffoldChild: Expanded(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    offer.title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MakeOfferView(offer: offer),
                      ),
                    );
                  },
                  child: Text(_locale.market.make_offer),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
