import 'package:sail_app/constant/app_strings.dart';
import 'package:sail_app/entity/user_subscribe_entity.dart';
import 'package:sail_app/utils/shared_preferences_util.dart';
import 'package:sail_app/view_model/base_view_model.dart';

class UserViewModel extends BaseViewModel {
  String _userEmail;
  bool _isFirst=true;
  bool _isLogin=false;
  UserSubscribeEntity _userSubscribeEntity;

  String get userEmail => _userEmail;

  bool get isFirst => _isFirst;
  bool get isLogin => _isLogin;

  UserSubscribeEntity get userSubscribeEntity => _userSubscribeEntity;

  refreshData() async {
    String token;
    await SharedPreferencesUtil.getInstance()
        .getString(AppStrings.TOKEN)
        .then((value) => token = value);
    if (token != null && token.isNotEmpty) {
      await SharedPreferencesUtil.getInstance()
          .getString(AppStrings.EMAIL)
          .then((value) => _userEmail = value);

      await SharedPreferencesUtil.getInstance()
          .getBool(AppStrings.IS_FIRST)
          .then((value) {
        _isFirst = value ??= true;
      });

      notifyListeners();
    }
  }

  setLogin() {
    _isLogin = true;
  }

  setLogout() {
    _isLogin = false;
  }

  setUserEmail(String userEmail) {
    _userEmail = userEmail;
  }

  setUserSubscribeEntity(UserSubscribeEntity userSubscribeEntity) {
    _userSubscribeEntity = userSubscribeEntity;
  }
}
