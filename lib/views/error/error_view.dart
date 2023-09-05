import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../localization/messages.i18n.dart';
import '../../main.dart';

class ErrorView extends ConsumerWidget {
  const ErrorView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);

    return Container(
      child: Center(
        child: Text(_locale.generalErrors.errorView),
      ),
    );
  }
}
