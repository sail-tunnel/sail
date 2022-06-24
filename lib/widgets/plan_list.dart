import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sail_app/constant/app_colors.dart';
import 'package:sail_app/entity/plan_entity.dart';
import 'package:sail_app/models/user_model.dart';
import 'package:sail_app/utils/navigator_util.dart';

class PlanList extends StatefulWidget {
  const PlanList(
      {Key key, @required this.isOn, @required this.boughtPlanId, @required this.plans})
      : super(key: key);

  final bool isOn;
  final int boughtPlanId;
  final List<PlanEntity> plans;

  @override
<<<<<<< HEAD
  _PlanListState createState() => _PlanListState();
=======
  PlanListState createState() => PlanListState();
>>>>>>> 380609e44586b1769df0bf5b9eb5acd4e8f5047e
}

class PlanListState extends State<PlanList> with AutomaticKeepAliveClientMixin {
  UserModel _userModel;

  @override
  bool get wantKeepAlive => true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userModel = Provider.of<UserModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(75)),
          child: Text(
            "Subscription plan",
            style: TextStyle(
                fontSize: ScreenUtil().setSp(32),
                color: widget.isOn ? AppColors.grayColor : Colors.grey[400],
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: ScreenUtil().setWidth(30)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(10)),
          child: Row(children: _buildConnections()),
        )
      ],
    );
  }

  List<Widget> _buildConnections() {
    List list = List<Widget>(widget.plans.length * 2 + 1);

    list[0] = SizedBox(width: ScreenUtil().setWidth(75));

    for (var i = 1; i < list.length; i++) {
      list[i] = Material(
        elevation: widget.isOn
            ? widget.plans[i ~/ 2].id == widget.boughtPlanId
                ? 3
                : 0
            : 0,
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
        color: widget.isOn
            ? widget.plans[i ~/ 2].id == widget.boughtPlanId
                ? Colors.white
                : const Color(0x15000000)
            : AppColors.darkSurfaceColor,
        child: InkWell(
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
            onTap: widget.isOn && widget.plans[i ~/ 2].id == widget.boughtPlanId
                ? null
                : () => _userModel.checkHasLogin(context, () => NavigatorUtil.goPlan(context)),
            child: Container(
                // width: ScreenUtil().setWidth(300),
                height: ScreenUtil().setWidth(200),
                padding:
                    EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40), vertical: ScreenUtil().setWidth(30)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Country name
                    Text(
                      widget.plans[i ~/ 2].name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(32),
                          color: widget.isOn
                              ? widget.plans[i ~/ 2].id == widget.boughtPlanId
                                  ? Colors.black
                                  : AppColors.grayColor
                              : Colors.white),
                    ),

                    // Connection status
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setWidth(40)),
                      child: widget.plans[i ~/ 2].id == widget.boughtPlanId
                          ? Row(
                              children: [
                                Icon(
                                  MaterialCommunityIcons.shield_check_outline,
<<<<<<< HEAD
                                  size: ScreenUtil().setWidth(25),
=======
                                  size: ScreenUtil().setWidth(32),
>>>>>>> 380609e44586b1769df0bf5b9eb5acd4e8f5047e
                                  color: const Color(0xFF1abb1d),
                                ),
                                Text(
                                  "subscribed",
                                  style: TextStyle(
<<<<<<< HEAD
                                      fontSize: ScreenUtil().setSp(25),
=======
                                      fontSize: ScreenUtil().setSp(32),
>>>>>>> 380609e44586b1769df0bf5b9eb5acd4e8f5047e
                                      color: const Color(0xFF1abb1d),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          : Text("choose",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(25),
                                  fontWeight: FontWeight.w500,
<<<<<<< HEAD
                                  color: widget.isOn
                                      ? Colors.black
                                      : Colors.yellow[500])),
=======
                                  color: widget.isOn ? Colors.black : Colors.yellow[700])),
>>>>>>> 380609e44586b1769df0bf5b9eb5acd4e8f5047e
                    )
                  ],
                ))),
      );

      list[++i] = SizedBox(width: ScreenUtil().setWidth(30));
    }
    return list;
  }
}
