import 'package:carbonless/providers/router_provider.dart';
import 'package:carbonless/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'localization/messages.i18n.dart';
import 'localization/messages_pl.i18n.dart';

final messagesProvider = StateProvider((ref) => const Messages());
final languageProvider =
    StateProvider((ref) => const Locale.fromSubtags(languageCode: 'en'));
final themeProvider = StateProvider((ref) => ThemeMode.light);
void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    ref.read(languageProvider.notifier).addListener((state) {
      if (state.languageCode == 'en') {
        ref.read(messagesProvider.notifier).state = const Messages();
      } else if (state.languageCode == 'pl') {
        ref.read(messagesProvider.notifier).state = const MessagesPl();
      }
    });
    return MaterialApp.router(
      title: 'Carbonless',
      locale: ref.watch(languageProvider),
      theme: appTheme,
      darkTheme: darkTheme,
      themeMode: ref.watch(themeProvider),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
