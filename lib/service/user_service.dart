import 'package:sail_app/constant/app_urls.dart';
import 'package:sail_app/entity/login_entity.dart';
import 'package:sail_app/entity/user_entity.dart';
import 'package:sail_app/entity/user_subscribe_entity.dart';
import 'package:sail_app/utils/http_util.dart';

class UserService {
  Future<LoginEntity> login(Map<String, dynamic> parameters) async {
    try {
      var result = await HttpUtil.instance.post(AppUrls.LOGIN, parameters: parameters);

      LoginEntity loginEntity = LoginEntity.fromMap(result['data']);

      return loginEntity;
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<bool> register(parameters) async {
    try {
      var result = await HttpUtil.instance.post(AppUrls.REGISTER, parameters: parameters);

      bool registerResult = result['data'];

      return registerResult;
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<UserSubscribeEntity> userSubscribe() async {
    try {
      var result = await HttpUtil.instance.get(AppUrls.USER_SUBSCRIBE);

      UserSubscribeEntity userSubscribeEntity = UserSubscribeEntity.fromMap(result['data']);

      return userSubscribeEntity;
    } catch (err) {
      return Future.error(err);
    }
  }

  Future<UserEntity> info() async {
    try {
      var result = await HttpUtil.instance.get(AppUrls.USER_INFO);

      UserEntity userEntity = UserEntity.fromMap(result['data']);

      return userEntity;
    } catch (err) {
      return Future.error(err);
    }
  }
}
