import '../providers/states/app_navigation_state.dart';
import '../providers/states/login_state.dart';
import '../auth/views/sign_up.dart';
import '../providers/states/auth_state.dart';
import '../providers/states/signup_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../auth/views/auth_choice.dart';
import '../auth/views/sign_in.dart';
import '../shared/bottom_nav_bar.dart';
import '../views/auxiliary_view/auxiliary_view.dart';
import '../views/exchange/offers/create/create_view.dart';
import 'controllers/app_navigation_controller_provider.dart';
import 'controllers/auth_controller_provider.dart';
import 'controllers/error_message_controller_provider.dart';
import 'controllers/exchange/offers/exchange_navigation_controller_provider.dart';
import 'controllers/login_controller_provider.dart';
import 'controllers/signup_controller_provider.dart';
import 'states/exchange/exchange_navigation_state.dart';

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
    _ref.listen<AppNavigationState>(
      appNavigationControllerProvider,
      (_, __) => notifyListeners(),
    );
    _ref.listen<ExchangeNavigationState>(
      exchangeNavigationControllerProvider,
      (_, __) => notifyListeners(),
    );
  }

  String? _redirectLogic(_, GoRouterState goRouterState) {
    /// todo: pomyslec nad zastosowaniem wzorca strategii!
    final authState = _ref.read(authControllerProvider);
    _ref.read(errorMessageControllerProvider.notifier).hideError();
    if (authState is AuthStateSuccess) {
      return authorizedRedirect(goRouterState);
    } else if (authState is AuthStateLogin) {
      return loginRedirect(goRouterState);
    } else if (authState is AuthStateSignup) {
      return signUpRedirect(goRouterState);
    } else if (authState is AuthStateChoice) {
      return goRouterState.matchedLocation == '/' ? null : '/';
    }
  }

  String? signUpRedirect(GoRouterState goRouterState) {
    final signUpState = _ref.read(signUpControllerProvider);
    if (signUpState is SignUpStateInitial || signUpState is SignUpStateError) {
      return goRouterState.matchedLocation == '/signup' ? null : '/signup';
    }
    // else if (signUpState is SignUpStateSuccess) {
    //   return goRouterState.location == '/home' ? null : '/home';
    // }
    return null;
  }

  String? loginRedirect(GoRouterState goRouterState) {
    final loginState = _ref.read(loginControllerProvider);
    final isLoggingIn = goRouterState.matchedLocation == '/login';
    if (loginState is LoginStateInitial || loginState is LoginStateError) {
      return isLoggingIn ? null : '/login';
    }
    // else if (loginState is LoginStateSuccess) {
    //   return goRouterState.location == '/home' ? null : '/home';
    // }
    return null;
  }

  String? authorizedRedirect(GoRouterState goRouterState) {
    final appNavigationState = _ref.read(appNavigationControllerProvider);
    if (appNavigationState is AppNavigationMain) {
      return mainRedirect(goRouterState, appNavigationState.view);
    } else {
      return goRouterState.matchedLocation == '/auxiliary'
          ? null
          : '/auxiliary';
    }
    return null;
  }

  String? mainRedirect(GoRouterState goRouterState, MainView viewType) {
    switch (viewType) {
      case MainView.Exchange:
        return exchangeRedirect(goRouterState);
      default:
        return goRouterState.matchedLocation == '/home' ? null : '/home';
    }
  }

  String? exchangeRedirect(GoRouterState goRouterState) {
    ExchangeNavigationState exchangeNavigationState =
        _ref.read(exchangeNavigationControllerProvider);
    if (exchangeNavigationState == const CreateOffer()) {
      return goRouterState.matchedLocation == '/create_offer'
          ? null
          : '/create_offer';
    } else {
      return goRouterState.matchedLocation == '/home' ? null : '/home';
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
          builder: (context, state) => BottomNavigationBarView(),
          path: '/home',
        ),
        GoRoute(
          name: 'AuthChoice',
          builder: (context, state) => AuthChoice(),
          path: '/',
        ),
        GoRoute(
          name: 'Auxiliary',
          builder: (context, state) => AuxiliaryView(),
          path: '/auxiliary',
        ),
        GoRoute(
          name: 'Create Offer',
          builder: (context, state) => CreateOfferView(),
          path: '/create_offer',
        )
      ];
}

extension GoRouterExtension on GoRouter {
  String location() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    final String location = matchList.uri.toString();
    return location;
  }
}
