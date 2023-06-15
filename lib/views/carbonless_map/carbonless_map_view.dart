import 'package:carbonless/main.dart';
import 'package:carbonless/providers/controllers/geolocation/geolocation_controller_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoder/geocoder.dart';

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
  @override
  Widget build(BuildContext context) {
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
              center: LatLng(49.5, -0.09),
              zoom: 5.0,
            ),
            layers: [
              TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
                tileBuilder: ref.watch(themeProvider) == ThemeMode.light
                    ? null
                    : darkModeTileBuilder,
                // backgroundColor: Colors.black54,
              ),
              MarkerLayerOptions(
                markers: [
                  Marker(
                    width: 80.0,
                    height: 80.0,
                    point: point,
                    builder: (ctx) => Container(
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                      ),
                    ),
                  )
                ],
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
