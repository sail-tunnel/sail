import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:sail_app/pages/home/home_page.dart';
import 'package:sail_app/pages/404/not_find_page.dart';
import 'package:sail_app/pages/home/main_page.dart';
import 'package:sail_app/pages/login/login_page.dart';
import 'package:sail_app/pages/login/register_page.dart';
import 'package:sail_app/pages/webview_widget.dart';
import 'dart:convert';

//引导页
var splashHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
      return MainPage();
    });

//首页
var homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
      return HomePage();
    });

//404页面
var notFindHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
      return NotFindPage();
    });

var loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
      return LoginPage();
    });

var registerHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
      return RegisterPage();
    });

var webViewHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
      var title = jsonDecode(parameters["titleName"].first);
      var url = jsonDecode(parameters["url"].first);
      return WebViewPage(url, title);
    });
