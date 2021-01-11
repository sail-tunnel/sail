import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:sail_app/pages/guide/guide_page.dart';
import 'package:sail_app/pages/home/home_page.dart';
import 'package:sail_app/pages/404/not_find_page.dart';
import 'package:sail_app/pages/home/main_page.dart';
import 'package:sail_app/pages/login/login_page.dart';
import 'package:sail_app/pages/plan/plan_page.dart';
import 'package:sail_app/pages/server_list.dart';
import 'package:sail_app/pages/webview_widget.dart';
import 'dart:convert';

//入口
Handler rootHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
      return MainPage();
    });

//引导页
Handler splashHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
      return GuidePage();
    });

//首页
Handler homeHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
      return HomePage();
    });

//404页面
Handler notFindHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
      return NotFindPage();
    });

Handler loginHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
      return LoginPage();
    });

Handler planHandle = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
      return PlanPage();
    });

Handler serverListHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
      return ServerListPage();
    });

Handler webViewHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> parameters) {
      var title = jsonDecode(parameters["titleName"].first);
      var url = jsonDecode(parameters["url"].first);
      return WebViewPage(url, title);
    });
