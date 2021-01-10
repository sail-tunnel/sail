import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sail_app/constant/app_colors.dart';
import 'package:sail_app/pages/home/home_page.dart';

class RecentConnection extends StatefulWidget {
  const RecentConnection(
      {Key key,
      @required this.isOn,
      @required this.lastConnectedIndex,
      @required this.parent, @required this.countries})
      : super(key: key);

  final bool isOn;
  final int lastConnectedIndex;
  final HomePageState parent;
  final List countries;

  _RecentConnectionState createState() => _RecentConnectionState();
}

class _RecentConnectionState extends State<RecentConnection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(75)),
          child: Text(
            "最近连接节点",
            style: TextStyle(
                color: widget.isOn ? AppColors.GRAY_COLOR : Colors.grey[400],
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: 15),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(bottom: 5),
          child: Row(children: _buildConnections()),
        )
      ],
    );
  }

  List<Widget> _buildConnections() {
    List list = new List<Widget>((widget.countries.length * 2) + 1);

    list[0] = SizedBox(width: ScreenUtil().setWidth(75));

    for (var i = 1; i < list.length; i++) {
      list[i] = Material(
        elevation: widget.isOn
            ? i == widget.lastConnectedIndex
                ? 3
                : 0
            : 0,
        borderRadius: BorderRadius.circular(15),
        color: widget.isOn
            ? i == widget.lastConnectedIndex
                ? Colors.white
                : Color(0x15000000)
            : AppColors.DARK_SURFACE_COLOR,
        child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: widget.isOn && i == widget.lastConnectedIndex
                ? null
                : () {
                    widget.parent.checkHasLogin(() => widget.parent.changeLastConnectedIndex(i - 1));
                  },
            child: Container(
                width: 150,
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Flag
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Image.asset(
                          "assets/flags/${widget.countries[i ~/ 2]}.png",
                          scale: 2),
                    ),

                    // Country name
                    Text(
                      widget.countries[i ~/ 2],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: widget.isOn
                              ? i == widget.lastConnectedIndex
                                  ? Colors.black
                                  : AppColors.GRAY_COLOR
                              : Colors.white),
                    ),

                    // Connection status
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: widget.isOn && i == widget.lastConnectedIndex
                          ? Row(
                              children: [
                                Icon(
                                  MaterialCommunityIcons.shield_check_outline,
                                  size: ScreenUtil().setWidth(32),
                                  color: Color(0xFF1abb1d),
                                ),
                                Text(
                                  "已连接",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Color(0xFF1abb1d),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            )
                          : Text("连接",
                              style: TextStyle(
                                  fontSize: 13,
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
