import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sail_app/constant/app_colors.dart';
import 'package:sail_app/constant/app_strings.dart';
import 'package:sail_app/models/app_model.dart';
import 'package:sail_app/models/server_model.dart';
import 'package:sail_app/models/user_model.dart';
import 'package:sail_app/models/user_subscribe_model.dart';
import 'package:sail_app/pages/my_profile.dart';
import 'package:sail_app/pages/plan/plan_page.dart';
import 'package:sail_app/pages/server_list.dart';
import 'package:sail_app/widgets/home_widget.dart';
import 'package:sail_app/widgets/power_btn.dart';
import 'package:sail_app/widgets/sail_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  late AppModel _appModel;
  late ServerModel _serverModel;
  late UserModel _userModel;
  late UserSubscribeModel _userSubscribeModel;
  bool _isLoadingData = false;
  String _appTitle = 'Sail';

  final Map _tabMap = {
    0: AppStrings.appName,
    1: '套餐',
    2: '节点',
    3: '我的',
  };

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
      await _serverModel.getServerList(forceRefresh: true);
      await _serverModel.getSelectServer();
      await _serverModel.getSelectServerList();
    }
  }

  void jumpToPage(int page) {
    setState(() {
      _pageController.jumpToPage(page);
      _appTitle = _tabMap[page];
      print("_appTitle: $_appTitle");
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: _appModel.isOn ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        child: Scaffold(
            appBar: SailAppBar(
              appTitle: _appTitle,
            ),
            extendBody: true,
            backgroundColor: _appModel.isOn ? AppColors.yellowColor : AppColors.grayColor,
            body: SafeArea(
                bottom: false,
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
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
                        onPressed: () => jumpToPage(0),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.wallet,
                          color: Colors.white,
                        ),
                        onPressed: () => jumpToPage(1),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(50),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.cloud_rounded,
                          color: Colors.white,
                        ),
                        onPressed: () => jumpToPage(2),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        onPressed: () => jumpToPage(3),
                      )
                    ],
                  ),
                ))));
  }
}
