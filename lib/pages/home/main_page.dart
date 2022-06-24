import 'package:flutter/cupertino.dart';
import 'package:sail_app/constant/app_dimens.dart';
import 'package:sail_app/pages/guide/guide_page.dart';
import 'package:sail_app/models/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key key}) : super(key: key);

  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    UserModel userViewModel = Provider.of<UserModel>(context);

<<<<<<< HEAD
    ScreenUtil.init(context,
        width: AppDimens.maxWidth,
        height: AppDimens.maxHeight,
        allowFontScaling: false);
    return userViewModel.isFirst
=======
    ScreenUtil.init(context, designSize: const Size(AppDimens.maxWidth, AppDimens.maxHeight));
    return userViewModel.isFirstOpen
>>>>>>> 380609e44586b1769df0bf5b9eb5acd4e8f5047e
        ? const GuidePage()
        : const HomePage();
  }
}
