import '/localization/messages.i18n.dart';
import '/models/partner_model.dart';
import '/providers/controllers/app_navigation_controller_provider.dart';
import '/providers/controllers/partners/partners_controller_provider.dart';
import '/providers/controllers/partners/partners_filter_provider.dart';
import '/shared/bottom_nav_bar.dart';
import '/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import '../../providers/states/partner/partners_filter_state.dart';
import '../../utils/partners_utils.dart';

class PartnersList extends ConsumerStatefulWidget {
  const PartnersList({Key? key}) : super(key: key);

  @override
  ConsumerState<PartnersList> createState() => _PartnersListState();
}

class _PartnersListState extends ConsumerState<PartnersList> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        List<Partner> partners = ref.watch(partnersNotifier);
        PartnersFilterState partnersFilterState =
            ref.watch(partnersFilterControllerProvider);
        List<Partner> filteredPartners =
            PartnersUtils.filter(partners, partnersFilterState);
        return Expanded(
          child: ListView(
            children: [
              for (Partner partner in filteredPartners)
                PartnerDialogGesture(partner: partner),
            ],
          ),
        );
      },
    );
  }
}

class PartnerTile extends ConsumerStatefulWidget {
  Partner partner;

  PartnerTile({Key? key, required this.partner}) : super(key: key);

  @override
  ConsumerState<PartnerTile> createState() => _PartnerTileState();
}

class _PartnerTileState extends ConsumerState<PartnerTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 400,
      // height: 200,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Card(
          elevation: 0,
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.partner.name,
                  style: logoTextStyle,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      'https://www.zooplus.pt/magazine/wp-content/uploads/2021/04/border-collie-im-grass-1024x683-1.jpg',
                      // width: 300,
                      // height: 100,
                      height: 130,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ShowOnMapButton extends ConsumerWidget {
  Partner partner;

  ShowOnMapButton({Key? key, required this.partner}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    return ElevatedButton(
      onPressed: () {
        ref
            .read(partnersFilterControllerProvider.notifier)
            .filterByPartner(partner);
        ref.read(appNavigationControllerProvider.notifier).showMain();
        // ref.read(bottomNavIndexProvider.notifier).state =
        //     bottomNavViewIndex.MAP.index;
      },
      child: Text(_locale.partners.show_on_map),
    );
  }
}

class PartnersSearch extends ConsumerStatefulWidget {
  const PartnersSearch({Key? key}) : super(key: key);

  @override
  ConsumerState<PartnersSearch> createState() => _PartnersSearchState();
}

class _PartnersSearchState extends ConsumerState<PartnersSearch> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.all(16.0),
          hintText: "Search for your localisation",
          prefixIcon: Icon(Icons.location_on_outlined),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              ref.read(partnersFilterControllerProvider.notifier).showAll();
              _searchController.clear();
            },
          )),
      onChanged: (value) {
        ref.read(partnersFilterControllerProvider.notifier).filterByName(value);
      },
    );
  }
}

class PartnerDialogGesture extends ConsumerWidget {
  Partner partner;

  PartnerDialogGesture({Key? key, required this.partner}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Messages _locale = ref.watch(messagesProvider);
    PartnerTile partnerTile = PartnerTile(
      partner: partner,
    );
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            barrierDismissible: true,
            barrierColor: Colors.black.withOpacity(0.5),
            pageBuilder: (BuildContext context, _, __) {
              return Center(
                child: Card(
                  child: Container(
                    ///TODO: make this relative to the screen size
                    height: 344,
                    width: 320,
                    child: Column(
                      children: [
                        Hero(
                          tag: "partner${partnerTile.hashCode}",
                          child: partnerTile,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                    '${_locale.partners.what_activities_earn}${partner.name}?'),
                                Text(
                                    '${partner.name} to sieć kawiarni w Łodzi oferująca kawę i ciasta. Jest członkiem od 2023 roku'),
                                ShowOnMapButton(partner: partner),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return FadeTransition(
                opacity: TweenSequence(
                  <TweenSequenceItem<double>>[
                    TweenSequenceItem<double>(
                      tween: Tween<double>(begin: 0.0, end: 1.0),
                      weight: 1,
                    ),
                  ],
                ).animate(animation),
                child: child,
              );
            },
          ),
        );
      },
      child: Hero(
        tag: "partner${partnerTile.hashCode}",
        child: partnerTile,
      ),
    );
  }
}
