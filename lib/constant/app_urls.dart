class AppUrls {
  static const String baseUrl = 'https://v2b.cyril.vip'; // 基础接口地址
  static const String baseApiUrl = '$baseUrl/api/v1'; // 基础接口地址

  static const String login = '$baseApiUrl/passport/auth/login';
  static const String register = '$baseApiUrl/passport/auth/register';
  static const String getQuickLoginUrl = '$baseApiUrl/passport/auth/getQuickLoginUrl';

  static const String userSubscribe = '$baseApiUrl/user/getSubscribe';
  static const String plan = '$baseApiUrl/guest/plan/fetch';
  static const String server = '$baseApiUrl/user/server/fetch';
  static const String userInfo = '$baseApiUrl/user/info';
}
