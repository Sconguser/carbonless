import 'package:carbonless/models/partner_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';

Marker partnerMarker(Partner partner, LatLng point) {
  return Marker(
    width: 80,
    height: 80,
    point: point,
    builder: (context) => Container(
      child: Icon(
        Icons.location_on,
        color: Colors.red,
      ),
    ),
  );
}
