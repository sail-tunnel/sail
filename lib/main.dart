import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as services;
import 'package:sail_app/constant/app_strings.dart';
import 'package:provider/provider.dart';
import 'package:sail_app/models/server_model.dart';
import 'package:sail_app/models/user_subscribe_model.dart';
import 'package:sail_app/router/application.dart';
import 'package:sail_app/router/routers.dart';
import 'package:sail_app/models/user_model.dart';

import 'constant/app_colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var userViewModel = UserModel();
  var userSubscribeModel = UserSubscribeModel();
  var serverModel = ServerModel();

  await userViewModel.refreshData();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<UserModel>.value(value: userViewModel),
      ChangeNotifierProvider<UserSubscribeModel>.value(value: userSubscribeModel),
      ChangeNotifierProvider<ServerModel>.value(value: serverModel),
    ],
    child: SailApp()
  ));
}

class SailApp extends StatelessWidget {
  SailApp({Key key}) : super(key: key) {
    final router = FluroRouter();
    Routers.configureRoutes(router);
    Application.router = router;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    services.SystemChrome.setPreferredOrientations([
      services.DeviceOrientation.portraitUp,
      services.DeviceOrientation.portraitDown
    ]);

    return MaterialApp(
      // <--- /!\ Add the builder
      title: AppStrings.appName,
      navigatorKey: Application.navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: Application.router.generator,
      theme: ThemeData(
          primarySwatch: AppColors.themeColor,
          visualDensity: VisualDensity.adaptivePlatformDensity
      ),
    );
  }
}
