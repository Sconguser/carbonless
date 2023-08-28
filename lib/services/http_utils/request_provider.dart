import 'package:carbonless/services/http_utils/url_provider.dart';

enum Endpoint {
  ALL_PRIZES,
  USER_PRIZES,
  PARTNERS,
  HISTORY,
}

extension ParseToString on Endpoint {
  String toEndpoint() {
    switch (this) {
      case Endpoint.ALL_PRIZES:
        return prizes;
      case Endpoint.USER_PRIZES:
        return userPrizes;
      case Endpoint.PARTNERS:
        return partners;
      case Endpoint.HISTORY:
        return history;
    }
  }

  String toError() {
    return "$name request failed";
  }
}
