import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sail_app/constant/app_colors.dart';
import 'package:sail_app/pages/home/home_page.dart';

// ignore: must_be_immutable
class ConnectionStats extends StatefulWidget {
  ConnectionStats(this.parent);

  HomePageState parent;

  @override
  _ConnectionStatsState createState() => _ConnectionStatsState();
}

class _ConnectionStatsState extends State<ConnectionStats> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("00:15:02",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 40,
              color: AppColors.GRAY_COLOR,
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(75)),
          child: FlatButton(
              onPressed: () {
                widget.parent.checkHasLogin(() => widget.parent.selectServerNode());
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Icon(MaterialCommunityIcons.map_marker,
                    color: AppColors.GRAY_COLOR, size: 20),
                Text("其他节点",
                    style:
                        TextStyle(fontSize: 12, color: AppColors.GRAY_COLOR)),
                Icon(Icons.chevron_right, color: AppColors.GRAY_COLOR, size: 20)
              ])),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: ScreenUtil().setWidth(75), vertical: 10),
          child: Row(
            children: [
              // Download Stats

              Row(children: [
                // Download Icon
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xffff0000),
                            blurRadius: 13,
                            spreadRadius: -2)
                      ],
                      color: Color(0xffff0000),
                      borderRadius: BorderRadius.circular(13)),
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.arrow_downward,
                    color: Colors.white,
                  ),
                ),

                // Labels
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "下行速度",
                        style: TextStyle(
                            color: AppColors.GRAY_COLOR,
                            fontWeight: FontWeight.w500),
                      ),
                      RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: AppColors.GRAY_COLOR,
                                fontWeight: FontWeight.w900),
                            children: [
                              TextSpan(text: "75.9"),
                              TextSpan(
                                  text: " KB/s",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                            ]),
                      )
                    ],
                  ),
                )
              ]),

              Expanded(child: Container()),

              // Upload Stats
              Row(children: [
                // Upload Icon
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff03a305),
                            blurRadius: 13,
                            spreadRadius: -2)
                      ],
                      color: Color(0xff03a305),
                      borderRadius: BorderRadius.circular(13)),
                  padding: EdgeInsets.all(5),
                  child: Icon(
                    Icons.arrow_upward,
                    color: Colors.white,
                  ),
                ),

                // Labels
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "上行速度",
                        style: TextStyle(
                            color: AppColors.GRAY_COLOR,
                            fontWeight: FontWeight.w500),
                      ),
                      RichText(
                        text: TextSpan(
                            style: TextStyle(
                                color: AppColors.GRAY_COLOR,
                                fontWeight: FontWeight.w900),
                            children: [
                              TextSpan(text: "29.6"),
                              TextSpan(
                                  text: " KB/s",
                                  style:
                                      TextStyle(fontWeight: FontWeight.normal)),
                            ]),
                      )
                    ],
                  ),
                )
              ]),
            ],
          ),
        )
      ],
    );
  }
}
