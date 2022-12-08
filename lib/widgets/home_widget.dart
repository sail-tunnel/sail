import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sail/constant/app_colors.dart';
import 'package:sail/models/app_model.dart';
import 'package:sail/models/plan_model.dart';
import 'package:sail/models/user_model.dart';
import 'package:sail/models/user_subscribe_model.dart';
import 'package:sail/widgets/connection_stats.dart';
import 'package:sail/widgets/logo_bar.dart';
import 'package:sail/widgets/my_subscribe.dart';
import 'package:sail/widgets/plan_list.dart';
import 'package:sail/widgets/select_location.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  HomeWidgetState createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> with AutomaticKeepAliveClientMixin {
  late AppModel _appModel;
  late UserModel _userModel;
  late UserSubscribeModel _userSubscribeModel;
  late PlanModel _planModel;

  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appModel = Provider.of<AppModel>(context);
    _userModel = Provider.of<UserModel>(context);
    _userSubscribeModel = Provider.of<UserSubscribeModel>(context);
    _planModel = Provider.of<PlanModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Logo bar
            Padding(
              padding: EdgeInsets.only(left: ScreenUtil().setWidth(75), right: ScreenUtil().setWidth(75)),
              child: LogoBar(
                isOn: _appModel.isOn,
              ),
            ),

            Padding(
              padding: EdgeInsets.only(top: ScreenUtil().setWidth(30)),
              child: MySubscribe(
                isLogin: _userModel.isLogin,
                isOn: _appModel.isOn,
                userSubscribeEntity: _userSubscribeModel.userSubscribeEntity,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(30)),
              child: PlanList(
                isOn: _appModel.isOn,
                userSubscribeEntity: _userSubscribeModel.userSubscribeEntity,
                plans: _planModel.planEntityList,
              ),
            ),

            Container(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(75)),
                child: Stack(alignment: Alignment.center, children: [
                  Image.asset(
                    "assets/map.png",
                    scale: 3,
                    color: _appModel.isOn ? const Color(0x15000000) : AppColors.darkSurfaceColor,
                  ),
                ])),

            _appModel.isOn ? const ConnectionStats() : const SelectLocation(),
          ],
        ));
  }
}
