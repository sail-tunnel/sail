import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:provider/provider.dart';
import 'package:sail_app/constant/app_colors.dart';
import 'package:sail_app/models/server_model.dart';
import 'package:flutter/material.dart';
import 'package:sail_app/utils/navigator_util.dart';

class ServerListPage extends StatefulWidget {
  @override
  _ServerListPageState createState() => _ServerListPageState();
}

class _ServerListPageState extends State<ServerListPage> {
  ServerModel _serverModel;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _serverModel = Provider.of<ServerModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '节点列表',
          style: Theme.of(context)
              .textTheme
              .headline6
              .copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(ScreenUtil().setWidth(40)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                      text: TextSpan(
                          text: '请选择 ',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2
                              .copyWith(fontWeight: FontWeight.w700),
                          children: [
                            TextSpan(
                                text: '节点',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(fontWeight: FontWeight.normal))
                          ])),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: _serverModel.serverEntityList?.length ?? 0,
                      itemBuilder: (_, index) {
                        return Material(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).cardColor,
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  crossAxisAlignment: WrapCrossAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: ScreenUtil().setWidth(10),
                                    ),
                                    CircleAvatar(
                                      radius: ScreenUtil().setWidth(10),
                                      backgroundColor: ((_serverModel
                                          .serverEntityList[index]
                                          .lastCheckAt ??
                                          0) *
                                          1000 >
                                          DateTime.now()
                                              .toLocal()
                                              .microsecondsSinceEpoch +
                                              (1000 * 60))
                                          ? Colors.green
                                          : Colors.red,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Text(
                                      _serverModel.serverEntityList[index].name,
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Tags(
                                        itemCount: _serverModel
                                            .serverEntityList[index].tags.length,
                                        // required
                                        itemBuilder: (int i) {
                                          final item = _serverModel
                                              .serverEntityList[index].tags[i];

                                          return ItemTags(
                                            // Each ItemTags must contain a Key. Keys allow Flutter to
                                            // uniquely identify widgets.
                                            index: index,
                                            // required
                                            color: AppColors.THEME_COLOR,
                                            activeColor: AppColors.THEME_COLOR,
                                            textColor: Colors.black87,
                                            textActiveColor: Colors.black87,
                                            title: item,
                                            textStyle: TextStyle(
                                                fontSize: ScreenUtil().setSp(24)),
                                            onPressed: (item) => print(item),
                                            onLongPressed: (item) => print(item),
                                          );
                                        })
                                  ],
                                ),
                                InkWell(
                                  borderRadius:
                                  BorderRadius.circular(ScreenUtil().setWidth(30)),
                                  onTap: () {
                                    _serverModel.setSelectServerEntity(
                                        _serverModel.serverEntityList[index]);
                                    NavigatorUtil.goBack(context);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: ScreenUtil().setWidth(10),
                                          horizontal: ScreenUtil().setWidth(30)),
                                      child: Text(
                                        '选择',
                                        style: TextStyle(
                                            color: Colors.yellow[800],
                                            fontWeight: FontWeight.w500),
                                      )),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (_, index) => SizedBox(height: 10),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
