import 'package:carbonless_free/auth/views/sign_in.dart';
import 'package:carbonless_free/localization/messages.i18n.dart';
import 'package:carbonless_free/main.dart';
import 'package:carbonless_free/models/exchange_offer_model.dart';
import 'package:carbonless_free/providers/controllers/exchange/my_offer_list_controller_provider.dart';
import 'package:carbonless_free/shared/bottom_nav_bar.dart';
import 'package:carbonless_free/views/exchange/offers/offer_list/my_offers_list/my_offers_list_view.dart';
import 'package:carbonless_free/views/exchange/offers/offer_list/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  widgetRenderTest();
}

void widgetRenderTest() {
  testWidgets('Checks if all widgets in My Offer List view render correctly',
      (WidgetTester tester) async {
    await initView(tester);

    final buttonFinder = find.byType(ElevatedButton);
    expect(buttonFinder, findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -100));
    await tester.pumpAndSettle();

    final cardFinder = find.byWidgetPredicate(
      (Widget widget) => widget is ExchangeTile,
      description: 'ExchangeTile',
    );
    expect(cardFinder, findsExactly(5));
  });
}

Future<void> initView(WidgetTester tester) async {
  await tester.pumpWidget(ProviderScope(
      overrides: [
        messagesProvider.overrideWith((ref) => Messages()),
        myOfferListNotifier.overrideWith(
            (ref) => MyOfferListNotifier(mockExchangeOfferList(), ref))
      ],
      child: MaterialApp(
        home: BottomNavigationBarView(scaffoldChild: MyOffersListView()),
      )));
}

List<ExchangeOffer> mockExchangeOfferList() {
  return [
    ExchangeOffer(
      id: 0,
      username: 'Mioszek',
      location: 'Lowicz',
      description: 'Pralka w dobrym stanie, nieprzechodzona',
      title: 'Oddam pralkę',
      created_at: DateTime(2023, 10, 13),
    ),
    ExchangeOffer(
      id: 1,
      username: 'Mioszek',
      location: 'Lowicz',
      description: 'Pralka w dobrym stanie, nieprzechodzona',
      title: 'Oddam pralkę',
      created_at: DateTime(2023, 11, 13),
    ),
    ExchangeOffer(
      id: 2,
      username: 'Mioszek',
      location: 'Lowicz',
      description: 'Pralka w dobrym stanie, nieprzechodzona',
      title: 'Oddam pralkę',
      created_at: DateTime(2023, 12, 13),
    ),
    ExchangeOffer(
      id: 3,
      username: 'Mioszek',
      location: 'Lowicz',
      description: 'Pralka w dobrym stanie, nieprzechodzona',
      title: 'Oddam pralkę',
      created_at: DateTime(2023, 10, 14),
    ),
    ExchangeOffer(
      id: 4,
      username: 'Mioszek',
      location: 'Lowicz',
      description: 'Pralka w dobrym stanie, nieprzechodzona',
      title: 'Oddam pralkę',
      created_at: DateTime(2023, 10, 15),
    ),
  ];
}
