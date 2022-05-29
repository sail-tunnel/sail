class AppUrls {
  static const String baseUrl = 'https://dns.github.bet/api/v1'; // 基础接口地址

  static const String login = '$baseUrl/passport/auth/login';
  static const String register = '$baseUrl/passport/auth/register';
  static const String userSubscribe = '$baseUrl/user/getSubscribe';
  static const String plan = '$baseUrl/guest/plan/fetch';
  static const String server = '$baseUrl/user/server/fetch';
  static const String userInfo = '$baseUrl/user/info';
}
