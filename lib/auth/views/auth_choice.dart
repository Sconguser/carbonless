import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthChoice extends ConsumerWidget {
  const AuthChoice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Row(
        children: [
          TextButton(
            child: Text('log in'),
            onPressed: () {},
          ),
          Text('/'),
          TextButton(
            child: Text('sign up'),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
