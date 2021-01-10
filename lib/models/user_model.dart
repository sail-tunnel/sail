import 'package:sail_app/constant/app_strings.dart';
import 'package:sail_app/entity/login_entity.dart';
import 'package:sail_app/entity/user_entity.dart';
import 'package:sail_app/utils/shared_preferences_util.dart';
import 'package:sail_app/models/base_model.dart';

class UserModel extends BaseModel {
  String _token;
  UserEntity _userEntity;
  bool _isFirst;
  bool _isLogin = false;

  String get token => _token;
  UserEntity get userEntity => _userEntity;
  bool get isFirst => _isFirst;
  bool get isLogin => _isLogin;

  refreshData() async {
    _isFirst =
        await SharedPreferencesUtil.getInstance().getBool(AppStrings.IS_FIRST) ?? true;
    String token =
        await SharedPreferencesUtil.getInstance().getString(AppStrings.TOKEN) ?? '';

    if (token != null && token.isNotEmpty) {
      _isLogin = true;
      _token = token;

      Map<String, dynamic> _userEntityMap = await SharedPreferencesUtil.getInstance()
          .getMap(AppStrings.USER_INFO) ?? Map<String, dynamic>();
      _userEntity = UserEntity.fromMap(_userEntityMap);

      notifyListeners();
    }
  }

  logout() {
    SharedPreferencesUtil sharedPreferencesUtil = SharedPreferencesUtil.getInstance();

    sharedPreferencesUtil.clear();
    setIsFirst(false);

    refreshData();
  }

  _saveIsFirst() {
    SharedPreferencesUtil.getInstance().setBool(AppStrings.IS_FIRST, _isFirst);
  }

  _saveUserToken(LoginEntity loginEntity) async {
    SharedPreferencesUtil sharedPreferencesUtil = SharedPreferencesUtil.getInstance();

    await sharedPreferencesUtil
        .setString(AppStrings.TOKEN, loginEntity.token);
  }

  _saveUserInfo() async {
    SharedPreferencesUtil sharedPreferencesUtil = SharedPreferencesUtil.getInstance();

    await sharedPreferencesUtil
        .setMap(AppStrings.USER_INFO, _userEntity.toMap());
  }

  setIsFirst(bool isFirst){
    _isFirst = isFirst;

    _saveIsFirst();
  }

  setToken(LoginEntity loginEntity) {
    _token = loginEntity.token;
    _isLogin = true;

    _saveUserToken(loginEntity);
  }

  setUserInfo(UserEntity userEntity) {
    _userEntity = userEntity;

    _saveUserInfo();
  }
}
