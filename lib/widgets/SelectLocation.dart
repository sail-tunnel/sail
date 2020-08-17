import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../constants.dart';

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
            
          },
          splashColor: Colors.grey,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: kYellowColor.withAlpha(200),
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
                Icon(MaterialCommunityIcons.map_marker),
                Text("Select Location",
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