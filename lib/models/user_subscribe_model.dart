import 'package:sail_app/constant/app_strings.dart';
import 'package:sail_app/entity/user_subscribe_entity.dart';
import 'package:sail_app/models/base_model.dart';
import 'package:sail_app/service/user_service.dart';
import 'package:sail_app/utils/shared_preferences_util.dart';

class UserSubscribeModel extends BaseModel {
  UserSubscribeEntity _userSubscribeEntity;

  UserService _userService = UserService();

  UserSubscribeEntity get userSubscribeEntity => _userSubscribeEntity;

  Future<bool> getUserSubscribe() async {
    bool result = false;

    UserSubscribeEntity userSubscribeEntity = await _userService.userSubscribe();
    setUserSubscribeEntity(userSubscribeEntity);

    notifyListeners();

    result = true;

    return result;
  }

  setUserSubscribeEntity(UserSubscribeEntity userSubscribeEntity) {
    _userSubscribeEntity = userSubscribeEntity;

    _saveUserSubscribe();
  }

  _saveUserSubscribe() async {
    SharedPreferencesUtil sharedPreferencesUtil = SharedPreferencesUtil.getInstance();

    await sharedPreferencesUtil.setMap(AppStrings.USER_INFO, _userSubscribeEntity.toMap());
  }
}
