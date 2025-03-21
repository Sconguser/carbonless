import '/services/http_utils/url_provider.dart';

enum Endpoint {
  ALL_PRIZES,
  USER_PRIZES,
  PARTNERS,
  HISTORY,
  HIGHSCORE,
  PRIZE_PURCHASE,
  POINTS_PURCHASE,
  SIGN_IN,
  SIGN_UP,
  VERIFY,
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
      case Endpoint.POINTS_PURCHASE:
        return pointsPurchase;
      case Endpoint.SIGN_IN:
        return signIn;
      case Endpoint.SIGN_UP:
        return signUp;
      case Endpoint.VERIFY:
        return verify;
    }
  }

  String toError() {
    return "$name request failed";
  }
}
