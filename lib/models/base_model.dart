import 'package:flutter/material.dart';
import 'package:sail_app/models/page_state.dart';

class BaseModel extends ChangeNotifier {
  PageState pageState = PageState.loading;
  bool _isDispose = false;
  var errorMessage;

  bool get isDispose => _isDispose;

  @override
  void notifyListeners() {
    print("view model notifyListeners");
    if (!_isDispose) {
      super.notifyListeners();
    }
  }

  errorNotify(String error) {
    pageState = PageState.error;
    errorMessage = error;
    notifyListeners();
  }

  @override
  void dispose() {
    _isDispose = true;
    print("view model dispose");
    super.dispose();
  }
}
