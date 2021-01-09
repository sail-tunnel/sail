import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sail_app/constant/app_colors.dart';
import 'package:sail_app/models/user_model.dart';
import 'package:sail_app/models/user_subscribe_model.dart';
import 'package:sail_app/utils/navigator_util.dart';

class LogoBar extends StatelessWidget {
  const LogoBar({
    Key key,
    @required this.isOn,
  }) : super(key: key);

  final bool isOn;

  @override
  Widget build(BuildContext context) {
    UserModel _userModel = Provider.of<UserModel>(context);
    UserSubscribeModel _userSubscribeModel = Provider.of<UserSubscribeModel>(context);

    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setWidth(60)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Text("瞰视云加速",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: ScreenUtil().setSp(60),
              color: isOn? AppColors.GRAY_COLOR: Colors.white,
            ),
          ),

          Row(
            children: [
              Material(
                color: isOn? Color(0x66000000): AppColors.DARK_SURFACE_COLOR,
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
                  onTap: (){
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10), horizontal: ScreenUtil().setWidth(30)),
                    child: Row(
                      children: [
                        Icon(MaterialCommunityIcons.wallet_outline,
                            color: Colors.yellow
                        ),
                        Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(5))),
                        Text('余额：${(_userSubscribeModel?.userSubscribeEntity?.balance ?? 0) / 100}',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              _userModel.isLogin ? Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(15))) : Container(),
              _userModel.isLogin ? Material(
                color: isOn? Color(0x66000000): AppColors.DARK_SURFACE_COLOR,
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
                  onTap: (){
                    _userModel.logout();
                    NavigatorUtil.goLogin(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: ScreenUtil().setWidth(10), horizontal: ScreenUtil().setWidth(30)),
                    child: Row(
                      children: [
                        Icon(MaterialCommunityIcons.exit_to_app,
                            color: Colors.yellow
                        ),
                        Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(5))),
                        Text('退出',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ) : Container(),
            ],
          )
        ],
      ),
    );
  }
}
