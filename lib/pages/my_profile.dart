import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sail_app/models/user_model.dart';
import 'package:sail_app/utils/navigator_util.dart';
import 'package:sail_app/widgets/profile_widget.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  MyProfileState createState() => MyProfileState();
}

class MyProfileState extends State<MyProfile> {
  late UserModel _userModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userModel = Provider.of<UserModel>(context);
  }

  void onLogoutTap() {
    _userModel.logout();
    NavigatorUtil.goLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          right: ScreenUtil().setWidth(32),
          left: ScreenUtil().setWidth(32),
          top: ScreenUtil().setHeight(32),
          bottom: ScreenUtil().setHeight(32)),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.only(top: 24, bottom: 24),
          child: Column(
            children: <Widget>[
              ProfileWidget(
                avatar: _userModel.userEntity?.avatarUrl,
                userName: _userModel.userEntity?.email ?? "欢迎光临",
                onTap: onLogoutTap,
              ),
              Container(
                padding: const EdgeInsets.only(top: 24, bottom: 24),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
                  ),
                ),
              ),
              const AccountWidget(),
              Container(
                padding: const EdgeInsets.only(top: 24, bottom: 24),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
                  ),
                ),
              ),
              const TicketWidget(),
              Container(
                padding: const EdgeInsets.only(top: 24, bottom: 24),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey[300]!)),
                  ),
                ),
              ),
              const StatisticsWidget()
            ],
          ),
        ),
      ),
    );
  }
}

class AccountWidget extends StatelessWidget {
  const AccountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "账户",
                  style: TextStyle(
                    color: Color(0xFFADADAD),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "💰 钱包",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "🔑 修改密码",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "📧 邮件通知",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "🔒 绑定第三方账号",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "🛡️ 重置订阅信息",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class TicketWidget extends StatelessWidget {
  const TicketWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "工单",
                  style: TextStyle(
                    color: Color(0xFFADADAD),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "🎫 我的工单",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class StatisticsWidget extends StatelessWidget {
  const StatisticsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "统计",
                  style: TextStyle(
                    color: Color(0xFFADADAD),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "🔖 流量明细",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Icon(Icons.arrow_forward_ios, size: 16),
              ],
            ),
          )
        ],
      ),
    );
  }
}
