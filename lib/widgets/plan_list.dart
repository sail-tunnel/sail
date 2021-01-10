import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sail_app/constant/app_colors.dart';
import 'package:sail_app/entity/plan_entity.dart';
import 'package:sail_app/pages/home/home_page.dart';

class PlanList extends StatefulWidget {
  const PlanList(
      {Key key,
        @required this.isOn,
      @required this.boughtPlanId,
      @required this.parent, @required this.plans})
      : super(key: key);

  final bool isOn;
  final int boughtPlanId;
  final HomePageState parent;
  final List<PlanEntity> plans;

  _PlanListState createState() => _PlanListState();
}

class _PlanListState extends State<PlanList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(75)),
          child: Text(
            "订阅套餐",
            style: TextStyle(
                color: widget.isOn ? AppColors.GRAY_COLOR : Colors.grey[400],
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
    List list = new List<Widget>(widget.plans.length * 2 + 1);

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
                : Color(0x15000000)
            : AppColors.DARK_SURFACE_COLOR,
        child: InkWell(
            borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
            onTap: widget.isOn && widget.plans[i ~/ 2].id == widget.boughtPlanId
                ? null
                : () {
                    widget.parent.checkHasLogin(() => widget.parent.changeBoughtPlanId(widget.plans[(i ~/ 2) - 1].id));
                  },
            child: Container(
                width: ScreenUtil().setWidth(300),
                height: ScreenUtil().setWidth(200),
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(40), vertical: ScreenUtil().setWidth(30)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Country name
                    Text(
                      widget.plans[i ~/ 2].name,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setWidth(35),
                          color: widget.isOn
                              ? widget.plans[i ~/ 2].id == widget.boughtPlanId
                                  ? Colors.black
                                  : AppColors.GRAY_COLOR
                              : Colors.white),
                    ),

                    // Connection status
                    Padding(
                      padding: EdgeInsets.only(top: ScreenUtil().setWidth(50)),
                      child: widget.plans[i ~/ 2].id == widget.boughtPlanId
                          ? Row(
                              children: [
                                Icon(
                                  MaterialCommunityIcons.shield_check_outline,
                                  size: ScreenUtil().setWidth(32),
                                  color: Color(0xFF1abb1d),
                                ),
                                Text(
                                  "已订阅",
                                  style: TextStyle(
                                      fontSize: ScreenUtil().setWidth(40),
                                      color: Color(0xFF1abb1d),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          : Text("选购",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setWidth(40),
                                  fontWeight: FontWeight.w500,
                                  color: widget.isOn
                                      ? Colors.black
                                      : Colors.yellow[700])),
                    )
                  ],
                ))),
      );

      list[++i] = SizedBox(width: ScreenUtil().setWidth(30));
    }
    return list;
  }
}
