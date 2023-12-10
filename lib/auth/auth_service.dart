import '/services/http_utils/http_service.dart';
import '/services/http_utils/request_provider.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_riverpod/flutter_riverpod.dart';

final authServiceProvider =
    Provider<AuthService>((ref) => AuthService(ref: ref));

class AuthService {
  final Ref ref;

  AuthService({required this.ref});

  Future<http.Response> login(String email, String password) async {
    Map<String, dynamic> body = {
      'user': {
        'email': email,
        'password': password,
      }
    };
    return ref.read(httpServiceProvider).executeHttp(
        RequestType.POST, body, null, Endpoint.SIGN_IN, null, null);
  }

  Future<http.Response> autoLogin(String bearerToken) async {
    return ref.read(httpServiceProvider).executeHttp(
        RequestType.GET, null, null, Endpoint.VERIFY, bearerToken, null);
  }

  Future<http.Response> registerUser(String email, String password,
      String passwordConfirmation, String name, String lastName) async {
    Map<String, dynamic> body = {
      'user': {
        'email': email,
        'name': name,
        'lastname': lastName,
        'password': password,
        'password_confirmation': passwordConfirmation
      }
    };
    return ref.read(httpServiceProvider).executeHttp(
        RequestType.POST, body, null, Endpoint.SIGN_UP, null, null);
  }
}
