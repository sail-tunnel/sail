import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sail/constant/app_colors.dart';
import 'package:sail/models/app_model.dart';

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
          style: TextStyle(color: _appModel.isOn ? Colors.black : Colors.white, fontWeight: FontWeight.w900),
        ),
        elevation: 0,
        backgroundColor: _appModel.isOn ? AppColors.yellowColor : AppColors.grayColor
);
  }
}
