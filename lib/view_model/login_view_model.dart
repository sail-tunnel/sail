import 'package:sail_app/entity/login_entity.dart';
import 'package:sail_app/entity/user_entity.dart';
import 'package:sail_app/service/user_service.dart';
import 'package:sail_app/view_model/base_view_model.dart';
import 'package:sail_app/view_model/user_view_model.dart';
import 'package:sail_app/constant/app_strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends BaseViewModel {
  UserService _userService = UserService();
  UserViewModel _userViewModel;

  LoginViewModel(this._userViewModel);


  Future<bool> login(String account, String passWord) async {
    bool result = false;
    var parameters = {
      'email': account,
      'password': passWord
    };
    LoginEntity loginEntity = await _userService.login(parameters);
    _saveUserToken(loginEntity);

    UserEntity userEntity = await _userService.info();
    _saveUserInfo(userEntity);
    _userViewModel.setUserEmail(
        userEntity.email);
    _userViewModel.setLogin();
    notifyListeners();

    result = true;

    return result;
  }

  _saveUserToken(LoginEntity loginEntity) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences
        .setString(AppStrings.TOKEN, loginEntity.token)
        .then((value) => print(value));
  }

  _saveUserInfo(UserEntity userEntity) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    await sharedPreferences.setString(
        AppStrings.EMAIL, userEntity.email);
  }
}
