import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sail/constant/app_colors.dart';
import 'package:sail/constant/app_strings.dart';
import 'package:provider/provider.dart';
import 'package:sail/models/app_model.dart';
import 'package:sail/models/plan_model.dart';
import 'package:sail/models/server_model.dart';
import 'package:sail/models/user_subscribe_model.dart';
import 'package:sail/router/application.dart';
import 'package:sail/router/routers.dart';
import 'package:sail/models/user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var appModel = AppModel();
  var userViewModel = UserModel();
  var userSubscribeModel = UserSubscribeModel();
  var serverModel = ServerModel();
  var planModel = PlanModel();

  await userViewModel.refreshData();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<AppModel>.value(value: appModel),
    ChangeNotifierProvider<UserModel>.value(value: userViewModel),
    ChangeNotifierProvider<UserSubscribeModel>.value(value: userSubscribeModel),
    ChangeNotifierProvider<ServerModel>.value(value: serverModel),
    ChangeNotifierProvider<PlanModel>.value(value: planModel)
  ], child: SailApp()));
}

class SailApp extends StatelessWidget {
  SailApp({Key? key}) : super(key: key) {
    final router = FluroRouter();
    Routers.configureRoutes(router);
    Application.router = router;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    services.SystemChrome.setPreferredOrientations(
        [services.DeviceOrientation.portraitUp, services.DeviceOrientation.portraitDown]);

    return MaterialApp(
      // <--- /!\ Add the builder
      title: AppStrings.appName,
      navigatorKey: Application.navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Application.router?.generator,
      localizationsDelegates: const [
        // 本地化的代理类
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', 'US'), // 美式英语
        Locale('zh', 'CN'), // 简体中文
        //其它Locales
      ],
      theme: ThemeData(primarySwatch: AppColors.themeColor, visualDensity: VisualDensity.adaptivePlatformDensity),
    );
  }
}
