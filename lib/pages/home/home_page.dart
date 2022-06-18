import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sail_app/channels/vpn_manager.dart';
import 'package:sail_app/constant/app_colors.dart';
import 'package:sail_app/entity/plan_entity.dart';
import 'package:sail_app/models/server_model.dart';
import 'package:sail_app/models/user_model.dart';
import 'package:sail_app/models/user_subscribe_model.dart';
import 'package:sail_app/pages/guide/guide_page.dart';
import 'package:sail_app/pages/plan/plan_page.dart';
import 'package:sail_app/pages/server_list.dart';
import 'package:sail_app/service/plan_service.dart';
import 'package:sail_app/utils/common_util.dart';
import 'package:sail_app/utils/navigator_util.dart';
import 'package:sail_app/widgets/connection_stats.dart';
import 'package:sail_app/widgets/logo_bar.dart';
import 'package:sail_app/widgets/my_subscribe.dart';
import 'package:sail_app/widgets/plan_list.dart';
import 'package:sail_app/widgets/power_btn.dart';
import 'package:sail_app/widgets/select_location.dart';

typedef Callback = Future<void> Function();

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  UserModel _userModel;
  UserSubscribeModel _userSubscribeModel;
  ServerModel _serverModel;
  List<PlanEntity> _planEntityList = [];
  bool isOn;
  int lastConnectedIndex = 1;
  bool _isLoadingData = false;
  VpnManager vpnManager = VpnManager();

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
    if (_serverModel.selectServerEntity == null) {
      Fluttertoast.showToast(
          msg: "Please select a server node",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 2,
          textColor: Colors.white,
          fontSize: 14.0);
      return;
    }

    await vpnManager.enableVPNManager();

    setState(() {
      isOn = !isOn;

      if (isOn) {
        print(_serverModel.selectServerEntity.toJson());
      }
    });
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: isOn ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        child: Scaffold(
            backgroundColor: isOn ? AppColors.yellowColor : AppColors.grayColor,
            body: SafeArea(
                child: PageView(
                  controller: _pageController,
              children: [
                _buildHomePage(),
                const PlanPage(),
                const ServerListPage(),
                const GuidePage()
              ],
            )),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              tooltip: 'Increment',
              elevation: 2.0,
              child: const Icon(
                Icons.power_settings_new,
                color: Colors.white,
              ),
            ),
            bottomNavigationBar: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ScreenUtil().setWidth(0)),
                    topRight: Radius.circular(ScreenUtil().setWidth(0))),
                child: BottomAppBar(
                  notchMargin: 8,
                  shape: const CircularNotchedRectangle(),
                  color: isOn ? AppColors.grayColor : AppColors.themeColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.home_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _pageController.jumpToPage(0);
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.wallet,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _pageController.jumpToPage(1);
                        },
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(50),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.print,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _pageController.jumpToPage(2);
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _pageController.jumpToPage(3);
                        },
                      )
                    ],
                  ),
                ))));
  }

  _buildHomePage() {
    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
            constraints: BoxConstraints(minHeight: ScreenUtil().setHeight(1920)),
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
                        color: isOn ? const Color(0x15000000) : AppColors.darkSurfaceColor,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [PowerButton(this)],
                      )
                    ])),

                isOn ? ConnectionStats(this) : SelectLocation(this),
              ],
            )));
  }
}
