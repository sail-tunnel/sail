import 'dart:convert';

import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:sail_app/pages/crisp_page.dart';
import 'package:sail_app/pages/plan/plan_page.dart';
import 'package:sail_app/pages/server_list.dart';
import 'package:sail_app/router/application.dart';
import 'package:sail_app/router/routers.dart';

class NavigatorUtil {
  static goMainPage(BuildContext context) {
    Application.router?.navigateTo(context, Routers.root,
        transition: TransitionType.inFromRight, replace: true);
  }

  static goGuidePage(BuildContext context) {
    Application.router?.navigateTo(context, Routers.guide,
        transition: TransitionType.inFromRight, replace: true);
  }

  static goHomePage(BuildContext context) {
    Application.router?.navigateTo(context, Routers.home,
        transition: TransitionType.inFromRight, replace: true);
  }

  static goLogin(BuildContext context) {
    Application.router?.navigateTo(context, Routers.login,
        transition: TransitionType.inFromRight, replace: true);
  }

  static goPlan(BuildContext context) {
    showCupertinoModalBottomSheet(
      context: context,
      builder: (context) => const PlanPage()
    );
    // Application.router.navigateTo(context, Routers.plan,
    //     transition: TransitionType.inFromRight);
  }

  static goServerList(BuildContext context) {
    showCupertinoModalBottomSheet(
        context: context,
        builder: (context) => const ServerListPage()
    );
    // Application.router.navigateTo(context, Routers.serverList,
    //     transition: TransitionType.inFromRight);
  }

  static goToCrisp(BuildContext context) {
    showCupertinoModalBottomSheet(
        context: context,
        builder: (context) => const CrispPage()
    );
  }

  static goWebView(BuildContext context, String titleName, String url) {
    String encodeUrl = Uri.encodeComponent(jsonEncode(url));
    String encodeTitleName = Uri.encodeComponent(jsonEncode(titleName));
    return Application.router?.navigateTo(
        context, "${Routers.webView}?titleName=$encodeTitleName&url=$encodeUrl",
        transition: TransitionType.inFromRight);
  }

  static goBack(BuildContext context) {
    Application.router?.pop(context);
  }
}
