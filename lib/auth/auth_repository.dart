import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_models/user_model.dart';
import 'package:http/http.dart' as http;

import 'auth_service.dart';

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

  Future<String?> login(String email, String password) async {
    http.Response response = await authService.login(email, password);
    _user = User.fromJson(jsonDecode(response.body));
    bearerToken = response.headers['authorization'];
    return bearerToken;
  }

  Future<String?> autoLogin(String bearerToken) async {
    http.Response response = await authService.autoLogin(bearerToken);
    _user = User.fromJson(jsonDecode(response.body));
    this.bearerToken = bearerToken;
    return bearerToken;
  }

  Future<bool> debugLogin() async {
    await Future.delayed(Duration(seconds: 3));
    _user = new User(
      id: 1,
      username: "Mioszek",
      email: "miosz@miosz.com",
      points: 30,
      total_carbon_saved: '100',
    );
    bearerToken = "dupa";
    return true;
  }

  Future<bool> signup(String email, String password,
      String passwordConfirmation, String name, String lastname) async {
    http.Response response = await authService.registerUser(
        email, password, passwordConfirmation, name, lastname);
    _user = User.fromJson(jsonDecode(response.body));
    bearerToken = response.headers['authorization'];
    return true;
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(authService: ref.read(authServiceProvider));
});
