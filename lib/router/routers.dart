import 'package:fluro/fluro.dart';
import 'package:sail_app/router/router_handlers.dart';

class Routers {
  static String root = "/";
  static String guide = "/guide";
  static String home = "/home";

  static String login = "/login";
  static String plan = "/plan";
  static String serverList = '/server-list';
  static String webView = "/webView";

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = notFindHandler;

    router.define(root, handler: rootHandler);

    router.define(guide, handler: splashHandler);

    router.define(home, handler: homeHandler);

    router.define(login, handler: loginHandler);

    router.define(plan, handler: planHandle);

    router.define(serverList, handler: serverListHandler);

    router.define(webView, handler: webViewHandler);
  }
}
