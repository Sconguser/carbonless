import 'package:carbonless_free/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../localization/messages.i18n.dart';
import '../../../../main.dart';
import '../../../../models/exchange_request_model.dart';

class RequestTile extends ConsumerWidget {
  const RequestTile({super.key, required this.exchangeRequest});
  final ExchangeRequest exchangeRequest;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        // _handleRequestClick(context);
      },
      child: Container(
        height: height * 0.2,
        padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        decoration: BoxDecoration(
          color: cardBackgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(children: [
          Align(
            alignment: Alignment.topRight,
            child: RequestPopupMenu(exchangeRequest: exchangeRequest),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(exchangeRequest.body),
          ),
        ]),
      ),
    );
  }
}

class RequestPopupMenu extends ConsumerWidget {
  const RequestPopupMenu({Key? key, required this.exchangeRequest})
      : super(key: key);
  final ExchangeRequest exchangeRequest;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton<String>(
      onSelected: (value) => {},
      itemBuilder: (BuildContext context) {
        return {'Delete'}.map((String choice) {
          return PopupMenuItem<String>(
            value: choice,
            child: Text(choice),
          );
        }).toList();
      },
    );
  }
}
