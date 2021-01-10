import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sail_app/constant/app_colors.dart';
import 'package:sail_app/entity/plan_entity.dart';
import 'package:sail_app/models/user_model.dart';
import 'package:sail_app/models/user_subscribe_model.dart';
import 'package:sail_app/service/plan_service.dart';
import 'package:sail_app/widgets/connection_stats.dart';
import 'package:sail_app/widgets/logo_bar.dart';
import 'package:sail_app/widgets/my_subscribe.dart';
import 'package:sail_app/widgets/plan_list.dart';
import 'package:sail_app/widgets/power_btn.dart';
import 'package:sail_app/widgets/recent_connection.dart';
import 'package:sail_app/widgets/select_location.dart';
import 'package:sail_app/utils/navigator_util.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  UserModel _userViewModel;
  UserSubscribeModel _userSubscribeModel;
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
    _userViewModel = Provider.of<UserModel>(context);
    _userSubscribeModel = Provider.of<UserSubscribeModel>(context);

    print('_onRefresh');
    print('_userViewModel: $_userViewModel');
    print('_userSubscribeModel: ${_userSubscribeModel.userSubscribeEntity?.toJson()}');
    if (_userViewModel.isLogin && !_isLoadingData) {
      _isLoadingData = true;
      await _userSubscribeModel.getUserSubscribe();
    }
  }

  void pressBtn() {
    if (!_userViewModel.isLogin) {
      NavigatorUtil.goLogin(context);
    } else {
      setState(() {
        isOn = !isOn;
      });
    }
  }

  void changeBoughtPlanId(id) {
    if (_userViewModel.isLogin) {
      _userSubscribeModel.getUserSubscribe();
    } else {
      NavigatorUtil.goLogin(context);
    }
  }

  void changeLastConnectedIndex(index) {
    setState(() {
      lastConnectedIndex = index;
      isOn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _userViewModel = Provider.of<UserModel>(context);

    return Scaffold(
      backgroundColor: isOn ? AppColors.YELLOW_COLOR : AppColors.GRAY_COLOR,
      body: Column(
        children: [
          // Logo bar
          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setWidth(75), left: ScreenUtil().setWidth(75), right: ScreenUtil().setWidth(75)),
            child: LogoBar(isOn: isOn),
          ),

          Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setWidth(30)),
            child: MySubscribe(
              isLogin: _userViewModel.isLogin,
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

          isOn ? ConnectionStats() : SelectLocation(),

          Padding(
            padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(30)),
            child: RecentConnection(
              isOn: isOn,
              lastConnectedIndex: lastConnectedIndex,
              parent: this,
              countries: ["United States"],
            ),
          ),
        ],
      ),
    );
  }
}
