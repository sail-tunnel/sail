import 'package:flutter/cupertino.dart';
import 'package:sail_app/constant/app_dimens.dart';
import 'package:sail_app/pages/guide/guide_page.dart';
import 'package:sail_app/models/user_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    UserModel _userViewModel = Provider.of<UserModel>(context);

    ScreenUtil.init(context,
        width: AppDimens.MAX_WIDTH,
        height: AppDimens.MAX_HEIGHT,
        allowFontScaling: false);
    return _userViewModel.isFirst
        ? GuidePage()
        : HomePage();
  }
}
