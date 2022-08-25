import 'package:flutter/cupertino.dart';
import 'package:sail_app/constant/app_dimens.dart';
import 'package:sail_app/pages/guide/guide_page.dart';
import 'package:sail_app/models/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    UserModel userViewModel = Provider.of<UserModel>(context);

    ScreenUtil.init(context, designSize: const Size(AppDimens.maxWidth, AppDimens.maxHeight));
    return userViewModel.isFirstOpen
        ? const GuidePage()
        : const HomePage();
  }
}
