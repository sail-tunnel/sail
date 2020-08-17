import 'package:flutter/material.dart';
import 'package:vpn_app/constants.dart';
import 'package:vpn_app/main.dart';

class PowerButton extends StatefulWidget {
  PowerButton(this.parent);
  MyHomePageState parent;

  @override
  _PowerButtonState createState() => _PowerButtonState();
}

class _PowerButtonState extends State<PowerButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: widget.parent.isOn? Color(0x20000000): Color(0xff606060),
        borderRadius: BorderRadius.circular(45),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(35),
        color: widget.parent.isOn? kGrayColor: Colors.grey,
        child: InkWell(
          splashColor: kYellowColor,
          onTap: (){
            widget.parent.pressBtn();
          },
          borderRadius: BorderRadius.circular(35),
          child: Container(
            padding: EdgeInsets.all(25),
            child: Icon(
              Icons.power_settings_new,
              size: 40,
              color: Colors.white,
            )
          ),
        ),
      ),
    );
  }
}