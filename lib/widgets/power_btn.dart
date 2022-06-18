import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:sail_app/constant/app_colors.dart';
import 'package:sail_app/models/app_model.dart';
import 'package:sail_app/models/server_model.dart';
import 'package:sail_app/models/user_model.dart';
import 'package:sail_app/utils/navigator_util.dart';

class PowerButton extends StatefulWidget {
  const PowerButton({Key key}) : super(key: key);

  @override
  PowerButtonState createState() => PowerButtonState();
}

class PowerButtonState extends State<PowerButton> {
  AppModel _appModel;
  UserModel _userModel;
  ServerModel _serverModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appModel = Provider.of<AppModel>(context);
    _userModel = Provider.of<UserModel>(context);
    _serverModel = Provider.of<ServerModel>(context);
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: _appModel.isOn ? const Color(0x20000000) : const Color(0xff606060),
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(120)),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(100)),
        color: _appModel.isOn ? AppColors.themeColor : Colors.grey,
        child: InkWell(
          splashColor: AppColors.yellowColor,
          onTap: () => _userModel.checkHasLogin(context, pressConnectBtn),
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(100)),
          child: Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
              child: Icon(
                Icons.power_settings_new,
                size: ScreenUtil().setWidth(100),
                color: Colors.white,
              )),
        ),
      ),
    );
  }
}
