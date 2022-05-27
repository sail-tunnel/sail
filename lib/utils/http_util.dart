import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:sail_app/constant/app_strings.dart';
import 'package:sail_app/router/application.dart';
import 'package:sail_app/router/routers.dart';

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
    dio.interceptors.add(CookieManager(CookieJar()));

    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) async {
      print("========================请求数据===================");
      print("url=${options.uri.toString()}");
      print("headers=${options.headers}");
      print("params=${options.data}");

      return handler.next(options);
    }, onResponse: (response, handler) {
      print("========================请求数据===================");
      print("code=${response.statusCode}");
      print("response=${response.data}");
      if (response.data[AppStrings.ERR_NO] == 501) {
        Application.navigatorKey.currentState.pushNamed(Routers.login);
        return handler.reject(new DioError(requestOptions: response.requestOptions));
      }

      return handler.next(response);
    }, onError: (error, handler) {
      print("========================请求错误===================");
      print("message =${error.message}");
      print("code=${error.response?.statusCode}");
      print("response=${error.response?.data}");

      return handler.next(error);
    }));
  }

  //get请求
  Future get(String url, {Map<String, dynamic> parameters, Options options}) async {
    Response response;
    if (parameters != null && options != null) {
      response = await dio.get(url, queryParameters: parameters, options: options);
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
  Future post(String url, {Map<String, dynamic> parameters, Options options}) async {
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
  Future put(String url, {Map<String, dynamic> parameters, Options options}) async {
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
  Future delete(String url, {Map<String, dynamic> parameters, Options options}) async {
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
