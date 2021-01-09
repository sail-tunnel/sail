import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sail_app/constant/app_colors.dart';
import 'package:sail_app/entity/user_subscribe_entity.dart';
import 'package:sail_app/pages/home/home_page.dart';
import 'package:sail_app/utils/transfer_util.dart';

class MySubscribe extends StatefulWidget {
  const MySubscribe(
      {Key key,
      @required this.isLogin,
      @required this.isOn,
      @required this.parent,
      @required this.userSubscribeEntity})
      : super(key: key);

  final bool isLogin;
  final bool isOn;
  final HomePageState parent;
  final UserSubscribeEntity userSubscribeEntity;

  _MySubscribeState createState() => _MySubscribeState();
}

class _MySubscribeState extends State<MySubscribe> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(left: ScreenUtil().setWidth(75)),
          child: Text(
            "我的订阅",
            style: TextStyle(
                color: widget.isOn ? AppColors.GRAY_COLOR : Colors.grey[400],
                fontWeight: FontWeight.w500),
          ),
        ),
        SizedBox(height: ScreenUtil().setWidth(30)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(10)),
          child: widget?.userSubscribeEntity?.plan == null
              ? _emptyWidget()
              : _buildConnections(),
        )
      ],
    );
  }

  Widget _emptyWidget() {
    return Container(
      width: ScreenUtil().setWidth(1080),
      height: ScreenUtil().setWidth(200),
      padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(75),
          vertical: ScreenUtil().setWidth(0)),
      child: Material(
        elevation: widget.isOn ? 3 : 0,
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
        color: widget.isOn ? Colors.white : AppColors.DARK_SURFACE_COLOR,
        child: Container(
          alignment: Alignment.center,
          child: Text(
            !widget.isLogin ? '请先登陆' :'请先订阅下方套餐',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: ScreenUtil().setWidth(40),
                color: widget.isOn ? Colors.black : Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildConnections() {
    return Container(
        width: ScreenUtil().setWidth(1080),
        height: ScreenUtil().setWidth(220),
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(75),
            vertical: ScreenUtil().setWidth(0)),
        child: Material(
          elevation: widget.isOn ? 3 : 0,
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(30)),
          color: widget.isOn ? Colors.white : AppColors.DARK_SURFACE_COLOR,
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: ScreenUtil().setWidth(30),
                horizontal: ScreenUtil().setWidth(40)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.userSubscribeEntity.plan.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setWidth(35),
                              color: widget.isOn ? Colors.black : Colors.white),
                        ),
                        Padding(
                            padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(15))),
                        Text(
                          widget.userSubscribeEntity?.expiredAt != null
                              ? '${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(widget.userSubscribeEntity.expiredAt * 1000))}过期'
                              : '长期有效',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setWidth(35),
                              color: widget.isOn ? Colors.black : Colors.white),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: ScreenUtil().setWidth(480),
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setWidth(15)),
                          child: LinearProgressIndicator(
                            backgroundColor:
                                widget.isOn ? Colors.black : Colors.white,
                            valueColor:
                                AlwaysStoppedAnimation(Colors.yellow[600]),
                            value: double.parse(((widget
                                                .userSubscribeEntity.u ??
                                            0 + widget.userSubscribeEntity.d ??
                                            0) /
                                        widget.userSubscribeEntity
                                            .transferEnable ??
                                    1)
                                .toStringAsFixed(2)),
                          ),
                        ),
                        Text(
                          '已用 ${TransferUtil().toHumanReadable(widget.userSubscribeEntity.u + widget.userSubscribeEntity.d)} / 总计 ${TransferUtil().toHumanReadable(widget.userSubscribeEntity.transferEnable)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil().setSp(26),
                              color: widget.isOn ? Colors.black : Colors.white),
                        )
                      ],
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: ScreenUtil().setWidth(150),
                      height: ScreenUtil().setWidth(75),
                      margin: EdgeInsets.only(right: ScreenUtil().setWidth(10)),
                      child: FlatButton(
                        color: Colors.yellow,
                        highlightColor: Colors.yellow[700],
                        colorBrightness: Brightness.dark,
                        splashColor: Colors.grey,
                        child: Text(
                          '续费',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: ScreenUtil().setSp(32)),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onPressed: () {},
                      ),
                    ),
                    Container(
                      width: ScreenUtil().setWidth(180),
                      height: ScreenUtil().setWidth(75),
                      child: FlatButton(
                        color: Colors.yellow,
                        highlightColor: Colors.yellow[700],
                        colorBrightness: Brightness.dark,
                        splashColor: Colors.grey,
                        child: Text(
                          '重置流量',
                          style: TextStyle(
                              color: Colors.black87,
                              fontSize: ScreenUtil().setSp(24)),
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0)),
                        onPressed: () {},
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
