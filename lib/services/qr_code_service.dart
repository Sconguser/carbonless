import 'package:carbonless/models/qr_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../shared/url_provider.dart';

final qrService = Provider<QrService>((ref) => QrService());

class QrService {
  final String _urlSend = '/machine_handlers';

  Future<http.Response> sendQr(QRDTO qrdto) async {
    try {
      final response = await http.post(
        Uri.https(url, _urlSend),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: qrdto.toJson(),
      );
      print('LOGIN USER: ${response.statusCode}');
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
