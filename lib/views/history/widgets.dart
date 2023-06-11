import 'package:carbonless/providers/controllers/history_list/history_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../auth/auth_models/user_model.dart';
import '../../auth/auth_repository.dart';
import '../../localization/messages.i18n.dart';
import '../../main.dart';
import '../../models/history_model.dart';
import '../../shared/constants.dart';

class TreesPlate extends ConsumerWidget {
  const TreesPlate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    User? user = ref.watch(authRepositoryProvider).user;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
          padding: standardOuterPadding,
          width: double.infinity,
          color: primaryColor,
          child: Column(
            children: [
              Text(
                _locale.history.trees_saved(10),
                style: labelTextStyle,
              ),
            ],
          )),
    );
  }
}

class HistoryCard extends ConsumerWidget {
  final History history;
  HistoryCard({Key? key, required this.history}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    User? user = ref.watch(authRepositoryProvider).user;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
          padding: standardOuterPadding,
          width: double.infinity,
          color: cardBackgroundColor,
          child: Card(
            color: cardBackgroundColor,
            elevation: 0,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    DateFormat.yMd().format(history.dateTime),
                    style: logoTextStyle.copyWith(fontSize: 14),
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      Icons.coffee,
                      size: 100,
                      color: primaryColor,
                    ),
                    Expanded(
                      child: Text(
                        history.text,
                        style: logoTextStyle.copyWith(fontSize: 15),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )),
    );
  }
}

class HistoryList extends ConsumerStatefulWidget {
  const HistoryList({Key? key}) : super(key: key);

  @override
  ConsumerState<HistoryList> createState() => _HistoryListState();
}

class _HistoryListState extends ConsumerState<HistoryList> {
  @override
  Widget build(BuildContext context) {
    Messages _locale = ref.watch(messagesProvider);
    List<History>? histories = ref.watch(historyNotifier);
    sortHistories(histories);
    return Expanded(
      child: ListView(
        children: [
          for (History history in histories!)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: HistoryCard(history: history),
            ),
        ],
      ),
    );
  }

  void sortHistories(List<History>? histories) {
    if (histories == null || histories.isEmpty) return;
    histories.sort((a, b) {
      if (a.dateTime.compareTo(b.dateTime) < 0) {
        return 1;
      } else {
        return -1;
      }
    });
  }
}
