import '/providers/controllers/app_settings/app_settings_controller_provider.dart';
import '/providers/router_provider.dart';
import '/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'localization/messages.i18n.dart';
import 'localization/messages_pl.i18n.dart';

final messagesProvider = StateProvider((ref) => const Messages());

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    final appSettings = ref.watch(appSettingsProvider);

    // ref.useEffect(() {
    //   appSettings.readAll(); // Call the readAll method on app start
    // }, []);
    ref.read(appSettingsProvider.notifier).addListener((state) {
      if (state.language == 'en') {
        ref.read(messagesProvider.notifier).state = const Messages();
      } else if (state.language == 'pl') {
        ref.read(messagesProvider.notifier).state = const MessagesPl();
      }
    });
    return MaterialApp.router(
      title: 'Carbonless Free',
      locale: Locale.fromSubtags(languageCode: appSettings.language),
      theme: appTheme,
      darkTheme: darkTheme,
      themeMode: appSettings.theme,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
