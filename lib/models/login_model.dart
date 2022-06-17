import 'package:sail_app/entity/user_entity.dart';
import 'package:sail_app/service/user_service.dart';
import 'package:sail_app/models/base_model.dart';
import 'package:sail_app/models/user_model.dart';

class LoginModel extends BaseModel {
  final UserService _userService = UserService();
  final UserModel _userModel;

  LoginModel(this._userModel);

  // 登陆方法
  Future<UserEntity> login(String account, String passWord) async {
    var parameters = {'email': account, 'password': passWord};

    return _userService.login(parameters).then((loginEntity) {
      _userModel.setToken(loginEntity);

      return _userService.info();
    }).then((userEntity) {
      _userModel.setUserInfo(userEntity);
      notifyListeners();

      return userEntity;
    });
  }
}
