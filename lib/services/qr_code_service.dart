import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'http_utils/url_provider.dart';

final qrService = Provider<QrService>((ref) => QrService());

class QrService {
  final String _urlSend = '/machine_handlers';

  Future<http.Response> sendQrPost(
      Map<String, dynamic> qrdto, String bearerToken) async {
    try {
      final response = await http.post(
        Uri.https(url, _urlSend),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': bearerToken,
        },
        body: jsonEncode(qrdto),
      );
      print('SEND QR CODE: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 202) {
        return response;
      } else {
        throw Exception('Sending code failed');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<http.Response> sendQrPatch(
      Map<String, dynamic> qrdto, String bearerToken) async {
    try {
      final response = await http.patch(
        Uri.https(url, _urlSend),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': bearerToken,
        },
        body: jsonEncode(qrdto),
      );
      print('SEND QR CODE: ${response.statusCode}');
      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw Exception('Sending code failed');
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
