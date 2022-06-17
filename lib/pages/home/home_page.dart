import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sail_app/constant/app_colors.dart';
import 'package:sail_app/models/app_model.dart';
import 'package:sail_app/pages/guide/guide_page.dart';
import 'package:sail_app/pages/plan/plan_page.dart';
import 'package:sail_app/pages/server_list.dart';
import 'package:sail_app/widgets/home_widget.dart';

typedef Callback = Future<void> Function();

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(initialPage: 0);
  AppModel _appModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appModel = Provider.of<AppModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: _appModel.isOn ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
        child: Scaffold(
            backgroundColor: _appModel.isOn ? AppColors.yellowColor : AppColors.grayColor,
            body: SafeArea(
                child: PageView(
              allowImplicitScrolling: true,
              controller: _pageController,
              children: const [HomeWidget(), PlanPage(), ServerListPage(), GuidePage()],
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
}
