import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import 'http_utils/url_provider.dart';

class PrizesService {
  final String _prizes = '/prizes';
  final String _userPrizes = '/user_prizes';
}

final prizesServiceProvider = Provider<PrizesService>((ref) => PrizesService());
