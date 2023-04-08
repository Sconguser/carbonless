import 'package:carbonless/providers/redirects/redirect.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../controllers/login_controller_provider.dart';
import '../states/login_state.dart';

class LoginRedirect implements Redirect {
  @override
  String? redirect(Ref ref, GoRouterState goRouterState) {
    final loginState = ref.read(loginControllerProvider);
    final isLoggingIn = goRouterState.location == '/login';
    if (loginState is LoginStateInitial) {
      return isLoggingIn ? null : '/login';
    } else if (loginState is LoginStateSuccess) {
      return goRouterState.location == '/home' ? null : '/home';
    }
    return null;
  }
}
