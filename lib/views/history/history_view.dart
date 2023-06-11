import 'package:carbonless/main.dart';
import 'package:carbonless/shared/constants.dart';
import 'package:carbonless/views/history/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../localization/messages.i18n.dart';

class HistoryView extends ConsumerWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    return Container(
      padding: standardOuterPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _locale.drawer.history,
            style: logoTextStyle,
          ),
          TreesPlate(),
          HistoryList(),
        ],
      ),
    );
  }
}
