import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sail_app/constant/app_colors.dart';
import 'package:sail_app/pages/server_list.dart';

class SelectLocation extends StatelessWidget {
  const SelectLocation({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical:20, horizontal: 30),
      child: Material(
        borderRadius: BorderRadius.circular(20),
        color: Colors.yellow[600],
        child: InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) {
              return ServerListPage();
            }));
          },
          splashColor: Colors.grey,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.YELLOW_COLOR.withAlpha(200),
                  blurRadius: 20,
                  spreadRadius: -6,
                  offset: Offset(
                    0.0,
                    3.0,
                  ),
                )
              ]
            ),
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Row(
              children: [
                Icon(MaterialCommunityIcons.server_network),
                Padding(padding: EdgeInsets.only(left: ScreenUtil().setWidth(10))),
                Text("选择连接节点",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold
                  ),
                ),
                Expanded(child: Container()),
                Icon(Icons.chevron_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
