import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ErrorMessageController extends ChangeNotifier {
  String? error;
  void setError(String error) {
    this.error = error;
    notifyListeners();
  }

  void hideError() {
    error = null;
    notifyListeners();
  }

  String? getError() {
    return error;
  }
}

final errorMessageControllerProvider =
    ChangeNotifierProvider((ref) => ErrorMessageController());
