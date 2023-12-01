import '/services/http_utils/url_provider.dart';

enum Endpoint {
  ALL_PRIZES,
  USER_PRIZES,
  PARTNERS,
  HISTORY,
  HIGHSCORE,
  PRIZE_PURCHASE,
  GENERATE_QR_CODE,
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
      case Endpoint.HIGHSCORE:
        return highscores;
      case Endpoint.PRIZE_PURCHASE:
        return prizePurchase;
      case Endpoint.GENERATE_QR_CODE:
        return generateCode;
    }
  }

  String toError() {
    return "$name request failed";
  }
}
