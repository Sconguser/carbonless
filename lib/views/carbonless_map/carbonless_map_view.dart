import 'package:carbonless/main.dart';
import 'package:carbonless/models/location_model.dart';
import 'package:carbonless/models/partner_model.dart';
import 'package:carbonless/providers/controllers/partners/partners_controller_provider.dart';
import 'package:carbonless/views/carbonless_map/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

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
  final PopupController _popupLayerController = PopupController();

  @override
  Widget build(BuildContext context) {
    List<Partner> partners = ref.watch(partnersNotifier);
    List<PartnerMarker> markers = [
      for (Partner partner in partners)
        for (Location location in partner.locations)
          PartnerMarker(
            partner: partner,
            location: LatLng(location.latitude, location.longitude),
          ),
    ];
    return Container(
      child: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              // onTap: (latlng, p) async {
              //   location = await Geocoder.local.findAddressesFromCoordinates(
              //       new Coordinates(p.latitude, p.longitude));
              //   setState(() {
              //     point = p;
              //     print(p);
              //   });

              // print(
              //     "${location.first.countryName} - ${location.first.featureName}");
              // },
              onTap: (_, __) {
                _popupLayerController.hideAllPopups();
              },
              center: LatLng(49.5, -0.09),
              zoom: 5.0,
            ),
            children: [
              TileLayerWidget(
                  options: TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                tileBuilder: ref.watch(themeProvider) == ThemeMode.light
                    ? null
                    : darkModeTileBuilder,
                // backgroundColor: Colors.black54,
              )),
              PopupMarkerLayerWidget(
                options: PopupMarkerLayerOptions(
                  markerRotate: false,
                  markers: markers,
                  popupController: _popupLayerController,
                  markerTapBehavior: MarkerTapBehavior.togglePopupAndHideRest(),
                  popupSnap: PopupSnap.markerTop,
                  popupBuilder: (BuildContext context, Marker marker) {
                    return MarkerPopup(marker: marker as PartnerMarker);
                  },
                  onPopupEvent: (dynamic popupEvent, List<Marker> marker) {
                    print('popupevent');
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 34.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Card(
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(16.0),
                      hintText: "Search for your localisation",
                      prefixIcon: Icon(Icons.location_on_outlined),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
