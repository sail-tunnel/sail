import 'package:dio/dio.dart';
import 'package:sail_app/constant/app_strings.dart';
import 'package:sail_app/router/application.dart';
import 'package:sail_app/router/routers.dart';
import 'package:sail_app/utils/shared_preferences_util.dart';

class HttpUtil {
  // 工厂模式
  static HttpUtil get instance => _getInstance();
  static HttpUtil _httpUtil;
  Dio dio;

  static HttpUtil _getInstance() {
    if (_httpUtil == null) {
      _httpUtil = HttpUtil();
    }
    return _httpUtil;
  }

  HttpUtil() {
    BaseOptions options = BaseOptions(
      connectTimeout: 10000,
      receiveTimeout: 10000,
    );
    dio = new Dio(options);
    dio.interceptors
        .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
      print("========================请求数据===================");
      print("url=${options.uri.toString()}");
      print("params=${options.data}");
      dio.lock();

      //如果token存在在请求头加上token
      await SharedPreferencesUtil.getInstance()
          .getString(AppStrings.TOKEN)
          .then((token) {
        options.headers[AppStrings.TOKEN] = token;
        print("token=$token");
      });
      dio.unlock();
      return options;
    }, onResponse: (Response response) {
      print("========================请求数据===================");
      print("code=${response.statusCode}");
      print("response=${response.data}");
      if (response.data[AppStrings.ERR_NO] == 501) {
        Application.navigatorKey.currentState.pushNamed(Routers.login);
        dio.reject("");
      }
      return response;
    }, onError: (DioError error) {
      print("========================请求错误===================");
      print("message =${error.message}");
      print("code=${error.response.statusCode}");
      print("response=${error.response.data}");
      return error;
    }));
  }

  //get请求
  Future get(String url,
      {Map<String, dynamic> parameters, Options options}) async {
    Response response;
    if (parameters != null && options != null) {
      response =
      await dio.get(url, queryParameters: parameters, options: options);
    } else if (parameters != null && options == null) {
      response = await dio.get(url, queryParameters: parameters);
    } else if (parameters == null && options != null) {
      response = await dio.get(url, options: options);
    } else {
      response = await dio.get(url);
    }
    return response.data;
  }

  //post请求
  Future post(String url,
      {Map<String, dynamic> parameters, Options options}) async {
    Response response;
    if (parameters != null && options != null) {
      response = await dio.post(url, data: parameters, options: options);
    } else if (parameters != null && options == null) {
      response = await dio.post(url, data: parameters);
    } else if (parameters == null && options != null) {
      response = await dio.post(url, options: options);
    } else {
      response = await dio.post(url);
    }
    return response.data;
  }

  //put请求
  Future put(String url,
      {Map<String, dynamic> parameters, Options options}) async {
    Response response;
    if (parameters != null && options != null) {
      response = await dio.put(url, data: parameters, options: options);
    } else if (parameters != null && options == null) {
      response = await dio.put(url, data: parameters);
    } else if (parameters == null && options != null) {
      response = await dio.put(url, options: options);
    } else {
      response = await dio.put(url);
    }
    return response.data;
  }

  //delete请求
  Future delete(String url,
      {Map<String, dynamic> parameters, Options options}) async {
    Response response;
    if (parameters != null && options != null) {
      response = await dio.delete(url, data: parameters, options: options);
    } else if (parameters != null && options == null) {
      response = await dio.delete(url, data: parameters);
    } else if (parameters == null && options != null) {
      response = await dio.delete(url, options: options);
    } else {
      response = await dio.delete(url);
    }
    return response.data;
  }
}
