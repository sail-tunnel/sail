import 'package:flutter/material.dart';
import 'package:sail_app/models/page_state.dart';
import 'package:sail_app/utils/common_util.dart';

class BaseModel extends ChangeNotifier {
  PageState pageState = PageState.loading;
  bool _isDispose = false;
  late String errorMessage;

  bool get isDispose => _isDispose;

  @override
  void notifyListeners() {
    print("view model notifyListeners");
    if (!_isDispose) {
      super.notifyListeners();
    }
  }

  void errorNotify(String error) {
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
