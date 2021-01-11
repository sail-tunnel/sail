import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sail_app/constant/app_colors.dart';
import 'package:sail_app/entity/plan_entity.dart';
import 'package:sail_app/models/server_model.dart';
import 'package:sail_app/models/user_model.dart';
import 'package:sail_app/models/user_subscribe_model.dart';
import 'package:sail_app/widgets/recent_connection_bottom_sheet.dart';
import 'package:sail_app/service/plan_service.dart';
import 'package:sail_app/widgets/connection_stats.dart';
import 'package:sail_app/widgets/logo_bar.dart';
import 'package:sail_app/widgets/my_subscribe.dart';
import 'package:sail_app/widgets/plan_list.dart';
import 'package:sail_app/widgets/power_btn.dart';
import 'package:sail_app/widgets/select_location.dart';
import 'package:sail_app/utils/navigator_util.dart';

typedef Callback = Future<void> Function();

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  UserModel _userModel;
  UserSubscribeModel _userSubscribeModel;
  ServerModel _serverModel;
  List<PlanEntity> _planEntityList = List<PlanEntity>();
  bool isOn;
  int lastConnectedIndex = 1;
  bool _isLoadingData = false;

  @override
  void initState() {
    super.initState();
    isOn = false;

    PlanService().plan().then((planEntityList) {
      setState(() {
        _planEntityList = planEntityList;
      });
    });
  }

  @override
  void didChangeDependencies() async {

    super.didChangeDependencies();

    _onRefresh();
  }

  Future _onRefresh() async {
    _userModel = Provider.of<UserModel>(context);
    _userSubscribeModel = Provider.of<UserSubscribeModel>(context);
    _serverModel = Provider.of<ServerModel>(context);

    if (_userModel.isLogin && !_isLoadingData) {
      _isLoadingData = true;
      await _userSubscribeModel.getUserSubscribe();
      await _serverModel.getServerList();
      await _serverModel.getSelectServer();
      await _serverModel.getSelectServerList();
    }
  }

  Future<void> pressConnectBtn() async {
    setState(() {
      isOn = !isOn;
    });
  }

  Future<void> changeBoughtPlanId(id) async {
    NavigatorUtil.goPlan(context);
    // _userSubscribeModel.getUserSubscribe();
  }

  Future<void> changeLastConnectedIndex(index) async {
    setState(() {
      lastConnectedIndex = index;
      isOn = false;
    });
  }

  Future<void> selectServerNode() async {
    await NavigatorUtil.goServerList(context);
  }

  Future<void> checkHasLogin(Callback callback) async {
    if (!_userModel.isLogin) {
      NavigatorUtil.goLogin(context);
    } else {
      return callback();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isOn ? AppColors.YELLOW_COLOR : AppColors.GRAY_COLOR,
      body: Stack(
        children: [
          SafeArea(child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                constraints: BoxConstraints(minHeight: ScreenUtil().setHeight(1920 - 175)),
                child: Column(
                  children: [
                    // Logo bar
                    Padding(
                      padding: EdgeInsets.only(left: ScreenUtil().setWidth(75), right: ScreenUtil().setWidth(75)),
                      child: LogoBar(isOn: isOn),
                    ),

                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setWidth(30)),
                      child: MySubscribe(
                        isLogin: _userModel.isLogin,
                        isOn: isOn,
                        parent: this,
                        userSubscribeEntity: _userSubscribeModel.userSubscribeEntity,
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(30)),
                      child: PlanList(
                        isOn: isOn,
                        boughtPlanId: _userSubscribeModel?.userSubscribeEntity?.planId ?? 0,
                        parent: this,
                        plans: _planEntityList,
                      ),
                    ),

                    Container(
                        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(75)),
                        child: Stack(alignment: Alignment.center, children: [
                          Image.asset(
                            "assets/map.png",
                            scale: 3,
                            color:
                            isOn ? Color(0x15000000) : AppColors.DARK_SURFACE_COLOR,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [PowerButton(this)],
                          )
                        ])
                    ),

                    isOn ? ConnectionStats(this) : SelectLocation(this),

                    // Padding(
                    //   padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(30)),
                    //   child: RecentConnection(
                    //     isOn: isOn,
                    //     lastConnectedIndex: lastConnectedIndex,
                    //     parent: this,
                    //     countries: ["United States"],
                    //   ),
                    // ),
                  ],
                )
              ))),
          RecentConnectionBottomSheet()
        ],
      )
    );
  }
}
