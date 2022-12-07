import 'package:sail/constant/app_urls.dart';
import 'package:sail/entity/login_entity.dart';
import 'package:sail/entity/user_entity.dart';
import 'package:sail/entity/user_subscribe_entity.dart';
import 'package:sail/utils/http_util.dart';

class UserService {
  Future<LoginEntity>? login(Map<String, dynamic> parameters) {
    return HttpUtil.instance?.post(AppUrls.login, parameters: parameters).then((result) {
      return LoginEntity.fromMap(result['data']);
    });
  }

  Future<String>? getQuickLoginUrl(Map<String, dynamic> parameters) {
    return HttpUtil.instance?.post(AppUrls.getQuickLoginUrl, parameters: parameters).then((result) {
      return result['data'];
    });
  }

  Future<bool>? register(parameters) {
    return HttpUtil.instance?.post(AppUrls.register, parameters: parameters).then((result) {
      return result['data'];
    });
  }

  Future<UserSubscribeEntity>? userSubscribe() {
    return HttpUtil.instance?.get(AppUrls.userSubscribe).then((result) {
      return UserSubscribeEntity.fromMap(result['data']);
    });
  }

  Future<UserEntity>? info() {
    return HttpUtil.instance?.get(AppUrls.userInfo).then((result) {
      return UserEntity.fromMap(result['data']);
    });
  }
}
