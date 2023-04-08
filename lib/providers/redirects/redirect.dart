import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

abstract class Redirect {
  String? redirect(Ref ref, GoRouterState goRouterState);
}
