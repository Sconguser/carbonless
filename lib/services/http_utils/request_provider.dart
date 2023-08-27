enum Endpoint {
  ALL_PRIZES,
  USER_PRIZES,
}

extension ParseToString on Endpoint {
  String toEndpoint() {
    switch (this) {
      case Endpoint.ALL_PRIZES:
        return '/prizes';
      case Endpoint.USER_PRIZES:
        return '/users_prizes';
    }
  }

  String toError() {
    switch (this) {
      case Endpoint.ALL_PRIZES:
        return 'All prizes failed';
      case Endpoint.USER_PRIZES:
        return 'User prizes failed';
    }
  }
}
