import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:vpn_app/constants.dart';

import 'widgets/ConnectionStats.dart';
import 'widgets/LogoBar.dart';
import 'widgets/PowerBtn.dart';
import 'widgets/RecentConnection.dart';
import 'widgets/SelectLocation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  
  Widget build(BuildContext context) {
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primarySwatch: Colors.yellow
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = true;
  }

  void pressBtn(){
    setState(() {
      isOn = !isOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isOn? kYellowColor: kGrayColor,
      
      body: Column(
        children: [

          // Logo bar
          Padding(
            padding: const EdgeInsets.only(top: 30,left: 30, right: 30),
            child: LogoBar(isOn: isOn),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: RecentConnection(isOn: isOn),
          ),

          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset("assets/map.png",
                scale: 3,
                color: isOn?Color(0x15000000)
                :kDarkSurfaceColor,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  PowerButton(this),
                ],
              )
            ]
          ),

          isOn?
          ConnectionStats()
          :SelectLocation()
        ],
      ),
    );
  }

}