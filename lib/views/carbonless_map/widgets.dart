import 'package:carbonless/models/partner_model.dart';
import 'package:carbonless/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

import 'map_utils.dart';

class PartnerMarker extends Marker {
  final Partner partner;
  final LatLng location;
  PartnerMarker({required this.partner, required this.location})
      : super(
          point: location,
          width: 80,
          height: 80,
          builder: (context) => SizedBox(
            child: Icon(
              Icons.location_on,
              color: primaryColor,
            ),
          ),
        );
}

Marker partnerMarker(Partner partner, LatLng point) {
  return Marker(
    width: 80,
    height: 80,
    point: point,
    builder: (context) => Container(
      width: 80,
      height: 80,
      child: Icon(
        Icons.location_on,
        color: Colors.red,
      ),
    ),
    anchorPos: AnchorPos.align(AnchorAlign.top),
    // rotateAlignment: AnchorAlign.top,
  );
}

class MarkerPopup extends StatefulWidget {
  PartnerMarker marker;
  MarkerPopup({Key? key, required this.marker}) : super(key: key);

  @override
  State<MarkerPopup> createState() => _MarkerPopupState();
}

class _MarkerPopupState extends State<MarkerPopup> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(widget.marker.partner.name),
            ElevatedButton(
              onPressed: () async {
                await MapUtils.openMap(widget.marker.location.latitude,
                    widget.marker.location.longitude);
              },
              child: Text("Navigate to"),
            ),
          ],
        ),
      ),
    );
  }
}
