import 'dart:convert';

import 'package:carbonless/auth/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_models/user_model.dart';
import 'package:http/http.dart' as http;

enum AuthorizationStatus {
  uninitialized,
  unauthorized,
  authorized,
}

class AuthRepository {
  String? bearerToken;
  User? _user;
  User? get user => _user;

  AuthorizationStatus _authorizationStatus = AuthorizationStatus.uninitialized;
  AuthorizationStatus get authorizationStatus => _authorizationStatus;

  final AuthService authService;

  AuthRepository({required this.authService});

  Future<bool> login(String email, String password) async {
    http.Response response = await authService.login(email, password);
    _user = User.fromJson(jsonDecode(response.body));
    bearerToken = response.headers['authorization'];
    return true;
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(authService: ref.read(authServiceProvider));
});
