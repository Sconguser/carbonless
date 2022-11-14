import 'dart:math';

import 'package:carbonless/auth/views/sign_up.dart';
import 'package:carbonless/home/home_view.dart';
import 'package:carbonless/providers/controllers/auth_controller_provider.dart';
import 'package:carbonless/providers/controllers/signup_controller_provider.dart';
import 'package:carbonless/providers/states/auth_state.dart';
import 'package:carbonless/providers/states/login_state.dart';
import 'package:carbonless/providers/states/signup_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../auth/views/auth_choice.dart';
import '../auth/views/sign_in.dart';
import 'controllers/login_controller_provider.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final router = RouterNotifier(ref);
  return GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: router,
    routes: router._routes,
    redirect: router._redirectLogic,
  );
});

class RouterNotifier extends ChangeNotifier {
  final Ref _ref;

  RouterNotifier(this._ref) {
    _ref.listen<AuthState>(
      authControllerProvider,
      (_, __) => notifyListeners(),
    );
    _ref.listen<LoginState>(
      loginControllerProvider,
      (_, __) => notifyListeners(),
    );
    _ref.listen<SignUpState>(
      signUpControllerProvider,
      (_, __) => notifyListeners(),
    );
  }

  String? _redirectLogic(GoRouterState goRouterState) {
    /// todo: pomyslec nad zastosowaniem wzorca strategii!
    final authState = _ref.read(authControllerProvider);
    if (authState is AuthStateLogin) {
      final loginState = _ref.read(loginControllerProvider);
      final isLoggingIn = goRouterState.location == '/login';
      if (loginState is LoginStateInitial) {
        return isLoggingIn ? null : '/login';
      } else if (loginState is LoginStateSuccess) {
        return goRouterState.location == '/home' ? null : '/home';
      }
      return null;
    } else if (authState is AuthStateSignup) {
      final signUpState = _ref.read(signUpControllerProvider);
      if (signUpState is SignUpStateInitial) {
        return goRouterState.location == '/signup' ? null : '/signup';
      } else if (signUpState is SignUpStateSuccess) {
        return goRouterState.location == '/home' ? null : '/home';
      }
    } else if (authState is AuthStateChoice) {
      return goRouterState.location == '/' ? null : '/';
    }
  }

  List<GoRoute> get _routes => [
        GoRoute(
          name: 'Login',
          builder: (context, state) => SignIn(),
          path: '/login',
        ),
        GoRoute(
          name: 'SignUp',
          builder: (context, state) => SignUp(),
          path: '/signup',
        ),
        GoRoute(
          name: 'Home',
          builder: (context, state) => HomeView(),
          path: '/home',
        ),
        GoRoute(
          name: 'AuthChoice',
          builder: (context, state) => AuthChoice(),
          path: '/',
        )
      ];
}
