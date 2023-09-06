import 'package:carbonless_business/providers/states/qr_generator_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QrGeneratorController extends StateNotifier<QrGeneratorState> {
  QrGeneratorController(this.ref) : super(const QrGeneratorInitialState());
  final Ref ref;
  bool _initialized = false;

  void initialize() {
    /// todo: get value of machine from backend
    ///
    state = QrGeneratorShowCode(data: "Haroldek");
    _initialized = true;
  }

  void reset() {
    state = const QrGeneratorInitialState();
  }
}

final qrGeneratorControllerProvider =
    StateNotifierProvider<QrGeneratorController, QrGeneratorState>((ref) {
  return QrGeneratorController(ref);
});
