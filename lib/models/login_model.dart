import 'package:sail_app/entity/login_entity.dart';
import 'package:sail_app/entity/user_entity.dart';
import 'package:sail_app/service/user_service.dart';
import 'package:sail_app/models/base_model.dart';
import 'package:sail_app/models/user_model.dart';

class LoginModel extends BaseModel {
  UserService _userService = UserService();
  UserModel _userModel;

  LoginModel(this._userModel);

  // 登陆方法
  Future<bool> login(String account, String passWord) async {
    bool result = false;

    var parameters = {'email': account, 'password': passWord};
    LoginEntity loginEntity = await _userService.login(parameters);
    _userModel.setToken(loginEntity);

    UserEntity userEntity = await _userService.info();
    _userModel.setUserInfo(userEntity);

    notifyListeners();

    result = true;

    return result;
  }
}
