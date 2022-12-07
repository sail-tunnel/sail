import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sail/constant/app_colors.dart';
import 'package:sail/entity/plan_entity.dart';
import 'package:sail/entity/user_subscribe_entity.dart';
import 'package:sail/models/user_model.dart';
import 'package:sail/utils/navigator_util.dart';

class PlanList extends StatefulWidget {
  const PlanList({Key? key, required this.isOn, required this.userSubscribeEntity, required this.plans})
      : super(key: key);

  final bool isOn;
  final UserSubscribeEntity? userSubscribeEntity;
  final List<PlanEntity> plans;

  @override
  PlanListState createState() => PlanListState();
}

class PlanListState extends State<PlanList> with AutomaticKeepAliveClientMixin {
  late UserModel _userModel;

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
            "订阅套餐",
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
    if (widget.userSubscribeEntity == null) {
      return [Container()];
    }

    int boughtPlanId = widget.userSubscribeEntity!.expiredAt * 1000 < DateTime.now().millisecondsSinceEpoch
        ? 0
        : widget.userSubscribeEntity?.planId ?? 0;

    List<Widget> list = List.generate(widget.plans.length * 2 + 1, (i) => Container());

    list[0] = SizedBox(width: ScreenUtil().setWidth(75));

    for (var i = 1; i < list.length; i++) {
      list[i] = Material(
        elevation: widget.isOn
            ? widget.plans[i ~/ 2].id == boughtPlanId
                ? 3
                : 0
            : 0,
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
        color: widget.isOn
            ? widget.plans[i ~/ 2].id == boughtPlanId
                ? Colors.white
                : const Color(0x15000000)
            : AppColors.darkSurfaceColor,
        child: InkWell(
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
            onTap: widget.isOn && widget.plans[i ~/ 2].id == boughtPlanId
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
                              ? widget.plans[i ~/ 2].id == boughtPlanId
                                  ? Colors.black
                                  : AppColors.grayColor
                              : Colors.white),
                    ),

                    // Connection status
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setWidth(40)),
                      child: widget.plans[i ~/ 2].id == boughtPlanId
                          ? Row(
                              children: [
                                Icon(
                                  Icons.shield,
                                  size: ScreenUtil().setWidth(32),
                                  color: const Color(0xFF1abb1d),
                                ),
                                Text(
                                  "已订阅",
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setSp(32),
                                      color: const Color(0xFF1abb1d),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          : Text("选购",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(32),
                                  fontWeight: FontWeight.w500,
                                  color: widget.isOn ? Colors.black : Colors.yellow[700])),
                    )
                  ],
                ))),
      );

      list[++i] = SizedBox(width: ScreenUtil().setWidth(30));
    }

    return list;
  }
}
