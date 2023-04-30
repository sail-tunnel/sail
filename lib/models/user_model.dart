import 'package:sail/constant/app_strings.dart';
import 'package:sail/entity/login_entity.dart';
import 'package:sail/entity/user_entity.dart';
import 'package:sail/models/base_model.dart';
import 'package:sail/utils/navigator_util.dart';
import 'package:sail/utils/shared_preferences_util.dart';

class UserModel extends BaseModel {
  String? _token;
  String? _authData;
  UserEntity? _userEntity;
  bool _isLogin = false;

  String? get token => _token;
  String? get authData => _authData;
  UserEntity? get userEntity => _userEntity;
  bool get isLogin => _isLogin;

  Future<void> checkHasLogin(context, Function callback) async {
    if (!isLogin) {
      NavigatorUtil.goLogin(context);
    } else {
      return callback();
    }
  }

  refreshData() async {
    String token =
        await SharedPreferencesUtil.getInstance()?.getString(AppStrings.token) ?? '';
    String authData =
        await SharedPreferencesUtil.getInstance()?.getString(AppStrings.authData) ?? '';

    if (token.isNotEmpty && authData.isNotEmpty) {
      _isLogin = true;
      _token = token;
      _authData = authData;

      Map<String, dynamic> userEntityMap = await SharedPreferencesUtil.getInstance()
          ?.getMap(AppStrings.userInfo) ?? <String, dynamic>{};
      _userEntity = UserEntity.fromMap(userEntityMap);

      notifyListeners();
    }
  }

  logout() {
    SharedPreferencesUtil? sharedPreferencesUtil = SharedPreferencesUtil.getInstance();

    sharedPreferencesUtil?.clear();

    refreshData();
  }

  _saveUserToken(LoginEntity loginEntity) async {
    SharedPreferencesUtil? sharedPreferencesUtil = SharedPreferencesUtil.getInstance();

    await sharedPreferencesUtil
        ?.setString(AppStrings.token, loginEntity.token);
  }

  _setUserAuthData(LoginEntity loginEntity) async {
    SharedPreferencesUtil? sharedPreferencesUtil = SharedPreferencesUtil.getInstance();

    await sharedPreferencesUtil
        ?.setString(AppStrings.authData, loginEntity.authData);
  }

  _saveUserInfo() async {
    SharedPreferencesUtil? sharedPreferencesUtil = SharedPreferencesUtil.getInstance();

    await sharedPreferencesUtil
        ?.setMap(AppStrings.userInfo, _userEntity?.toMap());
  }

  setToken(LoginEntity loginEntity) {
    _token = loginEntity.token;
    _authData = loginEntity.authData;
    _isLogin = true;

    _saveUserToken(loginEntity);
    _setUserAuthData(loginEntity);
  }

  setUserInfo(UserEntity? userEntity) {
    _userEntity = userEntity;

    _saveUserInfo();
  }
}
