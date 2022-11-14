import 'package:carbonless/providers/router_provider.dart';
import 'package:carbonless/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Carbonless',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        inputDecorationTheme: InputDecorationTheme(
          fillColor: textInputFillColor,
        ),
      ),
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
