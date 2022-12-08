import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sail/constant/app_colors.dart';
import 'package:sail/constant/app_dimens.dart';
import 'package:sail/models/app_model.dart';
import 'package:sail/models/plan_model.dart';
import 'package:sail/models/server_model.dart';
import 'package:sail/models/user_model.dart';
import 'package:sail/models/user_subscribe_model.dart';
import 'package:sail/pages/my_profile.dart';
import 'package:sail/pages/plan/plan_page.dart';
import 'package:sail/pages/server_list.dart';
import 'package:sail/widgets/home_widget.dart';
import 'package:sail/widgets/power_btn.dart';
import 'package:sail/widgets/sail_app_bar.dart';
import 'package:sail/utils/common_util.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> with WidgetsBindingObserver {
  late AppModel _appModel;
  late ServerModel _serverModel;
  late UserModel _userModel;
  late UserSubscribeModel _userSubscribeModel;
  late PlanModel _planModel;
  bool _isLoadingData = false;
  bool _initialStatus = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('state = $state');

    if (state == AppLifecycleState.resumed) {
      _appModel.getStatus();
    }
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    _appModel = Provider.of<AppModel>(context);
    _userModel = Provider.of<UserModel>(context);
    _userSubscribeModel = Provider.of<UserSubscribeModel>(context);
    _serverModel = Provider.of<ServerModel>(context);
    _planModel = Provider.of<PlanModel>(context);

    if (_userModel.isLogin && !_isLoadingData) {
      _isLoadingData = true;
      await _userSubscribeModel.getUserSubscribe();
      await _serverModel.getServerList(forceRefresh: true);
      await _serverModel.getSelectServer();
      _appModel.setConfigProxies(_userModel, _serverModel);
    }

    if (!_initialStatus) {
      _initialStatus = true;
      _appModel.getStatus();
      _planModel.fetchPlanList();
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(AppDimens.maxWidth, AppDimens.maxHeight));

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: _appModel.isOn ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        child: Scaffold(
            appBar: SailAppBar(
              appTitle: _appModel.appTitle,
            ),
            extendBody: true,
            backgroundColor: _appModel.isOn ? AppColors.yellowColor : AppColors.grayColor,
            body: SafeArea(
                bottom: false,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _appModel.pageController,
                  children: const [HomeWidget(), PlanPage(), ServerListPage(), MyProfile()],
                )),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: const PowerButton(),
            bottomNavigationBar: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(ScreenUtil().setWidth(50)),
                    topRight: Radius.circular(ScreenUtil().setWidth(50))),
                child: BottomAppBar(
                  notchMargin: 8,
                  shape: const CircularNotchedRectangle(),
                  color: _appModel.isOn ? AppColors.grayColor : AppColors.themeColor,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.home_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () => _appModel.jumpToPage(0),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.wallet,
                          color: Colors.white,
                        ),
                        onPressed: () => _appModel.jumpToPage(1),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(50),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.cloud_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () => _appModel.jumpToPage(2),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        onPressed: () => _appModel.jumpToPage(3),
                      )
                    ],
                  ),
                ))));
  }
}
