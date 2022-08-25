import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail_app/constant/app_colors.dart';
import 'package:sail_app/models/app_model.dart';

class SailAppBar extends AppBar {
  SailAppBar({Key? key, required this.appTitle})
      : super(key: key);

  final String appTitle;

  @override
  SailAppBarState createState() => SailAppBarState();
}

class SailAppBarState extends State<SailAppBar> {
  late AppModel _appModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _appModel = Provider.of<AppModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          widget.appTitle,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: _appModel.isOn ? AppColors.grayColor : AppColors.themeColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
        ));
  }
}
