import 'dart:math';

import 'package:carbonless/home/home_view.dart';
import 'package:carbonless/providers/login_controller_provider.dart';
import 'package:carbonless/providers/states/login_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../auth/views/auth_choice.dart';
import '../auth/views/sign_in.dart';

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
    _ref.listen<LoginState>(
      loginControllerProvider,
      (_, __) => notifyListeners(),
    );
  }

  String? _redirectLogic(GoRouterState goRouterState) {
    final loginState = _ref.read(loginControllerProvider);
    final isLoggingIn = goRouterState.location == '/login';
    if (loginState is LoginStateInitial) {
      return isLoggingIn ? null : '/login';
    }
    if (loginState is LoginStateSuccess) {
      return goRouterState.location == '/home' ? null : '/home';
    }
    return null;
  }

  List<GoRoute> get _routes => [
        GoRoute(
            name: 'Login',
            builder: (context, state) => SignIn(),
            path: '/login'),
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
