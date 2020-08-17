import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:vpn_app/constants.dart';


class LogoBar extends StatelessWidget {
  const LogoBar({
    Key key,
    @required this.isOn,
  }) : super(key: key);

  final bool isOn;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        Text("VPN",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 25,
            color: isOn? kGrayColor: Colors.white,
          ),
        ),
        
        Expanded(child: Container()),

        // Premium Button
        Material(
          color: isOn? Color(0x66000000): kDarkSurfaceColor,
          borderRadius: BorderRadius.circular(15),
          child: InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: (){},
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 11, horizontal: 15),
              child: Row(
                children: [
                  Icon(MaterialCommunityIcons.crown,
                    color: Colors.yellow
                  ),
                  Text(" Go Premium",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
