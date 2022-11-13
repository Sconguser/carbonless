import 'package:carbonless/auth/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'auth_models/user_model.dart';

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

  Future<User?> login(String email, String password) async {
    return authService.login(email, password);
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(authService: ref.read(authServiceProvider));
});
