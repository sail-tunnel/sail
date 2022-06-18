import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sail_app/constant/app_colors.dart';
import 'package:sail_app/entity/plan_entity.dart';
import 'package:sail_app/models/app_model.dart';
import 'package:sail_app/models/server_model.dart';
import 'package:sail_app/models/user_model.dart';
import 'package:sail_app/models/user_subscribe_model.dart';
import 'package:sail_app/pages/home/home_page.dart';
import 'package:sail_app/service/plan_service.dart';
import 'package:sail_app/utils/navigator_util.dart';
import 'package:sail_app/widgets/connection_stats.dart';
import 'package:sail_app/widgets/logo_bar.dart';
import 'package:sail_app/widgets/my_subscribe.dart';
import 'package:sail_app/widgets/plan_list.dart';
import 'package:sail_app/widgets/power_btn.dart';
import 'package:sail_app/widgets/select_location.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key key}) : super(key: key);

  @override
  HomeWidgetState createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget> with AutomaticKeepAliveClientMixin {
  AppModel _appModel;
  UserModel _userModel;
  UserSubscribeModel _userSubscribeModel;
  ServerModel _serverModel;
  List<PlanEntity> _planEntityList = [];
  bool _isLoadingData = false;

  @override
  void initState() {
    super.initState();

    PlanService().plan().then((planEntityList) {
      setState(() {
        _planEntityList = planEntityList;
      });
    });
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    _appModel = Provider.of<AppModel>(context);
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

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
            constraints: BoxConstraints(minHeight: ScreenUtil().setHeight(1920)),
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
                    boughtPlanId: _userSubscribeModel?.userSubscribeEntity?.planId ?? 0,
                    plans: _planEntityList,
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
            )));
  }
}
