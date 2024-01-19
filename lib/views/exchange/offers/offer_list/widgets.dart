import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../localization/messages.i18n.dart';
import '../../../../main.dart';
import '../../../../models/exchange_offer_model.dart';
import '../../../../shared/constants.dart';
import '../../../../shared/utils.dart';
import '../exchange_details/exchange_details_view.dart';

class ExchangeTile extends ConsumerWidget {
  final ExchangeOffer offer;
  const ExchangeTile({
    super.key,
    required this.offer,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        handleOfferClick(context);
      },
      child: Container(
        height: height * 0.2,
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
          color: cardBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HintWidget(
                      hint: _locale.market.added,
                      widget: Text(dateTimeToString(offer.created_at)),
                    ),
                    HintWidget(
                      hint: _locale.market.user,
                      widget: Text(offer.username),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  offer.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(offer.description),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HintWidget(
                    hint: _locale.market.location,
                    widget: Text(offer.location),
                  ),
                  HintWidget(
                    hint: _locale.market.details,
                    widget: Icon(Icons.arrow_forward_ios, size: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handleOfferClick(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExchangeDetailsView(offer: offer),
      ),
    );
  }
}

class HintWidget extends StatelessWidget {
  final Widget widget;
  final String hint;
  const HintWidget({Key? key, required this.hint, required this.widget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          hint + " ",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        widget,
      ],
    );
  }
}
