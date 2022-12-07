import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sail/constant/app_colors.dart';
import 'package:sail/models/app_model.dart';
import 'package:sail/models/user_model.dart';
import 'package:sail/models/user_subscribe_model.dart';
import 'package:sail/utils/navigator_util.dart';

class LogoBar extends StatelessWidget {
  const LogoBar({
    Key? key,
    required this.isOn,
  }) : super(key: key);

  final bool isOn;

  @override
  Widget build(BuildContext context) {
    AppModel appModel = Provider.of<AppModel>(context);
    UserModel userModel = Provider.of<UserModel>(context);
    UserSubscribeModel userSubscribeModel = Provider.of<UserSubscribeModel>(context);

    return Container(
      margin: EdgeInsets.only(top: ScreenUtil().setWidth(60)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Sail",
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: ScreenUtil().setSp(60),
              color: isOn ? AppColors.grayColor : Colors.white,
            ),
          ),
          Row(
            children: [
              Material(
                color: isOn ? const Color(0x66000000) : AppColors.darkSurfaceColor,
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
                  onTap: () => NavigatorUtil.goToCrisp(context),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setWidth(10), horizontal: ScreenUtil().setWidth(30)),
                    child: Text(
                      "客服",
                      style:
                      TextStyle(fontSize: ScreenUtil().setSp(32), color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(15))),
              Material(
                color: isOn ? const Color(0x66000000) : AppColors.darkSurfaceColor,
                borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
                child: InkWell(
                  borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
                  onTap: () => appModel.jumpToPage(3),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setWidth(10), horizontal: ScreenUtil().setWidth(30)),
                    child: Text(
                      userSubscribeModel?.userSubscribeEntity?.email ?? "欢迎光临",
                      style:
                          TextStyle(fontSize: ScreenUtil().setSp(32), color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              userModel.isLogin ? Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(15))) : Container(),
              userModel.isLogin
                  ? Material(
                      color: isOn ? const Color(0x66000000) : AppColors.darkSurfaceColor,
                      borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
                        onTap: () {
                          userModel.logout();
                          NavigatorUtil.goLogin(context);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: ScreenUtil().setWidth(10), horizontal: ScreenUtil().setWidth(30)),
                          child: Text(
                            '退出',
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(32), color: Colors.white, fontWeight: FontWeight.w500),
                          ),
                        ),
                      ),
                    )
                  : Container(),
            ],
          )
        ],
      ),
    );
  }
}
