import 'package:carbonless/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/controllers/auth_controller_provider.dart';

class AuthChoice extends ConsumerStatefulWidget {
  const AuthChoice({Key? key}) : super(key: key);

  @override
  ConsumerState<AuthChoice> createState() => _AuthChoiceState();
}

class _AuthChoiceState extends ConsumerState<AuthChoice>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    // duration: const Duration(seconds: 2),
    vsync: this,
  );
  // late final Animation<Offset> _offsetAnimation = Tween<Offset>(
  //   begin: const Offset(1.5, 0.0),
  //   end: const Offset(0.0, 0.0),
  // ).animate(CurvedAnimation(
  //   parent: _controller,
  //   curve: Curves.bounceIn,
  // ));
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: Text(
                  'log in',
                  style: authChoiceTextStyle,
                ),
                onPressed: () {
                  ref.read(authControllerProvider.notifier).showLogin();
                },
              ),
              Text(
                '/',
                style: authChoiceTextStyle,
              ),
              TextButton(
                child: Text(
                  'sign up',
                  style: authChoiceTextStyle,
                ),
                onPressed: () {
                  ref.read(authControllerProvider.notifier).showSignUp();
                },
              ),
            ],
          ),
          tween: Tween<double>(
            begin: 0,
            end: 1,
          ),
          duration: Duration(seconds: 2),
          builder: (context, double val, child) {
            return Opacity(
              opacity: val,
              child: Padding(
                padding: EdgeInsets.only(top: val * 10),
                child: child,
              ),
            );
          },
        ),
      ),
    );
  }
}
