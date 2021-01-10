import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:sail_app/constant/app_strings.dart';
import 'package:provider/provider.dart';
import 'package:device_preview/device_preview.dart';
import 'package:sail_app/models/server_model.dart';
import 'package:sail_app/models/user_subscribe_model.dart';
import 'package:sail_app/router/application.dart';
import 'package:sail_app/router/routers.dart';
import 'package:sail_app/models/user_model.dart';

import 'constant/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var _userViewModel = UserModel();
  var _userSubscribeModel = UserSubscribeModel();
  var _serverModel = ServerModel();

  await _userViewModel.refreshData();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserModel>.value(value: _userViewModel),
      ChangeNotifierProvider<UserSubscribeModel>.value(value: _userSubscribeModel),
      ChangeNotifierProvider<ServerModel>.value(value: _serverModel),
    ],
    child: DevicePreview(
      enabled: false,
      builder: (context) => SailApp(),
    ),
  ));
}

class SailApp extends StatelessWidget {
  SailApp() {
    final router = FluroRouter();
    Routers.configureRoutes(router);
    Application.router = router;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.of(context).locale,
      // <--- /!\ Add the locale
      builder: DevicePreview.appBuilder,
      // <--- /!\ Add the builder
      title: AppStrings.APP_NAME,
      navigatorKey: Application.navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Application.router.generator,
      theme: ThemeData(
          primarySwatch: AppColors.THEME_COLOR,
          visualDensity: VisualDensity.adaptivePlatformDensity
      ),
    );
  }
}
