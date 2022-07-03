import 'package:flutter/material.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key key}) : super(key: key);

  @override
  MyProfileState createState() => MyProfileState();
}

class MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text('MyProfile'),
        Text('MyProfile'),
      ],
    );
  }
}
