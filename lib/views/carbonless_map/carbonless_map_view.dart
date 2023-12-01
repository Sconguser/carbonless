import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import '../../localization/messages.i18n.dart';
import '../../main.dart';
import '../../models/location_model.dart';
import '../../models/partner_model.dart';
import '../../providers/controllers/app_settings/app_settings.dart';
import '../../providers/controllers/app_settings/app_settings_controller_provider.dart';
import '../../providers/controllers/partners/partners_controller_provider.dart';
import '../../providers/controllers/partners/partners_filter_provider.dart';
import '../../providers/states/partner/partners_filter_state.dart';
import '../../shared/constants.dart';
import '../../utils/partners_utils.dart';
import '/views/carbonless_map/widgets.dart';

class CarbonlessMapView extends ConsumerStatefulWidget {
  const CarbonlessMapView({Key? key}) : super(key: key);

  @override
  ConsumerState<CarbonlessMapView> createState() => _CarbonlessMapViewState();
}

class _CarbonlessMapViewState extends ConsumerState<CarbonlessMapView> {
  double long = 49.5;
  double lat = -0.09;
  LatLng point = LatLng(49.5, -0.09);
  var location = [];
  final TextEditingController _searchController = TextEditingController();
  final PopupController _popupLayerController = PopupController();
  late MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Messages _locale = ref.watch(messagesProvider);
    AppSettings appSettings = ref.watch(appSettingsProvider);
    return Container(
      child: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              // onTap: (latlng, p) async {
              //   LatLng p = LatLng(60, 60);
              //   setState(() {
              //     point = p;
              //     print(p);
              //   });
              // },
              // print(
              //     "${location.first.countryName} - ${location.first.featureName}");
              // },
              // onPositionChanged: (MapPosition position, bool hasGesture) {
              //   if (hasGesture) {
              //     setState(
              //       () =>
              //           _centerOnLocationUpdate = CenterOnLocationUpdate.never,
              //     );
              //   }
              // },
              onTap: (_, __) {
                _popupLayerController.hideAllPopups();
              },
              initialCenter: ref.watch(centerPointProvider),
              initialZoom: 5.0,
            ),
            children: [
              TileLayer(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                tileBuilder: appSettings.theme == ThemeMode.light
                    ? null
                    : darkModeTileBuilder,
                // backgroundColor: Colors.black54,
              ),
              Consumer(builder: (context, ref, child) {
                List<Partner> partners = ref.watch(partnersNotifier);
                PartnersFilterState partnersFilterState =
                    ref.watch(partnersFilterControllerProvider);
                List<Partner> filteredPartners =
                    PartnersUtils.filter(partners, partnersFilterState);
                List<PartnerMarker> markers = [
                  for (Partner partner in filteredPartners)
                    for (Location location in partner.locations)
                      PartnerMarker(
                        partner: partner,
                        location: LatLng(double.parse(location.latitude),
                            double.parse(location.longitude)),
                      ),
                ];

                return PopupMarkerLayer(
                  options: PopupMarkerLayerOptions(
                    markers: markers,
                    popupController: _popupLayerController,
                    markerTapBehavior:
                        MarkerTapBehavior.togglePopupAndHideRest(),
                    popupDisplayOptions: PopupDisplayOptions(
                      builder: (BuildContext context, Marker marker) {
                        return MarkerPopup(marker: marker as PartnerMarker);
                      },
                    ),
                    onPopupEvent: (dynamic popupEvent, List<Marker> marker) {
                      print('popupevent');
                    },
                  ),
                );
              }),
            ],
          ),
          Container(
            ///TODO: zamienic na relatywne
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 34.0),
            child: Column(
              children: [
                Card(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16.0),
                      hintText: _locale.map.search_bar_hint,
                      prefixIcon: Icon(Icons.location_on_outlined),
                    ),
                    onChanged: (value) {
                      print(value);
                      ref
                          .read(partnersFilterControllerProvider.notifier)
                          .filterByName(value);
                    },
                  ),
                ),
                Consumer(builder: (context, ref, child) {
                  PartnersFilterState partnersFilterState =
                      ref.watch(partnersFilterControllerProvider);
                  return partnersFilterState is PartnersFilterAll
                      ? const SizedBox.shrink()
                      : ElevatedButton(
                          child: Text(_locale.map.reset_filter),
                          onPressed: () {
                            ref
                                .read(partnersFilterControllerProvider.notifier)
                                .showAll();
                            _searchController.clear();
                          },
                        );
                })
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  width: 40,
                  height: 40,
                  color: Colors.white,
                  child: ClipRRect(
                    child: IconButton(
                      icon: Icon(
                        Icons.gps_fixed_outlined,
                        color: primaryColor,
                      ),
                      onPressed: () async {
                        // await ref
                        //     .read(geolocationProvider.notifier)
                        //     .getCurrentPosition();
                        // Location currentLocation =
                        //     ref.read(geolocationProvider);
                        // await ref
                        //     .read(geolocationProvider.notifier)
                        //     .getPartnersWithRange(
                        //         double.parse(currentLocation.latitude),
                        //         double.parse(currentLocation.longitude),
                        //         20);
                        // LatLng newPoint =
                        //     ref.read(geolocationProvider.notifier).getLatLng();
                        // ref.read(centerPointProvider.notifier).state = newPoint;
                        // _mapController.move(LatLng(60, 60), 20);
                      },
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

final centerPointProvider = StateProvider((ref) => LatLng(0, 0));
