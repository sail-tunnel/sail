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

class HomeWidgetState extends State<HomeWidget> {
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

  Future<void> pressConnectBtn() async {
    if (_serverModel.selectServerEntity == null) {
      Fluttertoast.showToast(
          msg: "请选择服务器节点",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          textColor: Colors.white,
          fontSize: 14.0);
      return;
    }

    _appModel.togglePowerButton();
  }

  Future<void> changeBoughtPlanId(id) async {
    NavigatorUtil.goPlan(context);
    // _userSubscribeModel.getUserSubscribe();
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
                    parent: this,
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [PowerButton(this, _appModel.isOn)],
                      )
                    ])),

                _appModel.isOn ? ConnectionStats(this) : SelectLocation(this),
              ],
            )));
  }
}
