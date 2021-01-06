import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail_app/constant/app_colors.dart';
import 'package:sail_app/view_model/user_view_model.dart';
import 'package:sail_app/widgets/connection_stats.dart';
import 'package:sail_app/widgets/logo_bar.dart';
import 'package:sail_app/widgets/power_btn.dart';
import 'package:sail_app/widgets/recent_connection.dart';
import 'package:sail_app/widgets/select_location.dart';
import 'package:sail_app/utils/navigator_util.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  UserViewModel _userViewModel;
  bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = true;
  }

  void pressBtn(){
    if (!_userViewModel.isLogin) {
      NavigatorUtil.goLogin(context);
    } else {
      setState(() {
        isOn = !isOn;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _userViewModel = Provider.of<UserViewModel>(context);

    return Scaffold(
      backgroundColor: isOn? AppColors.YELLOW_COLOR: AppColors.GRAY_COLOR,

      body: Column(
        children: [

          // Logo bar
          Padding(
            padding: const EdgeInsets.only(top: 30,left: 30, right: 30),
            child: LogoBar(isOn: isOn),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: RecentConnection(isOn: isOn),
          ),

          Stack(
              alignment: Alignment.center,
              children: [
                Image.asset("assets/map.png",
                  scale: 3,
                  color: isOn?Color(0x15000000)
                      :AppColors.DARK_SURFACE_COLOR,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        NavigatorUtil.goLogin(context);
                      },
                      child: PowerButton(this),
                    ),
                  ],
                )
              ]
          ),

          isOn?
          ConnectionStats()
              :SelectLocation()
        ],
      ),
    );
  }

}
