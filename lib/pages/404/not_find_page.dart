import 'package:flutter/material.dart';
import 'package:sail_app/constant/app_images.dart';
import 'package:sail_app/constant/app_strings.dart';


class NotFindPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(AppStrings.APP_NAME),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Image.asset(
            AppImages.NOT_FIND_PICTURE,
            width: 200,
            height: 100,
            color: Color(0xFFff5722),
          ),
        ));
  }
}
