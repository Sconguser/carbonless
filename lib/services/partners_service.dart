import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'http_utils/url_provider.dart';

class PartnersService {
  final String _urlPartners = '/partners';

  Future<http.Response> getPartnersWithRange(
      double lat, double log, double range, String bearerToken) async {
    try {
      Uri resolvedUrl = Uri.https(url, _urlPartners, {
        'latitude': lat.toString(),
        'longitude': log.toString(),
        'range': range.toString()
      });
      final response = await http.get(
        resolvedUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': bearerToken
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw Exception('getPartners with range failed');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}

final partnersServiceProvider =
    Provider<PartnersService>((ref) => PartnersService());
