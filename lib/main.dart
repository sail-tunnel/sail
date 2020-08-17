import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:vpn_app/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isOn;

  @override
  void initState() {
    super.initState();
    isOn = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isOn? kYellowColor: kGrayColor,
      
      body: Column(
        children: [

          // Logo bar
          Padding(
            padding: const EdgeInsets.only(top: 40,left: 30, right: 30),
            child: Row(
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
            ),
          ), // logo bar

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:30),
                  child: Text("Recent Connection",
                    style: TextStyle(
                      color: isOn? kGrayColor: Colors.white,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
                SizedBox(height: 15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(bottom: 5),
                  child: Row(
                    children: _buildConnections()
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  List<Widget> _buildConnections(){
    const countries = [
      "United States",
      "United Kingdom",
      "Germany",
      "Japan",
    ];
    List list = new List<Widget>((countries.length*2));

    list[0] = SizedBox(width: 30);

    for (var i = 1; i < list.length; i++) {

      list[i]= Material(
        elevation: isOn? i==1? 3:0 : 0,
        borderRadius: BorderRadius.circular(15),
        color: isOn? i==1? Colors.white: Color(0x15000000): kDarkSurfaceColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: isOn && i==1? null: (){},
          child: Container(
            width: 150,
            height: 100,
            padding: EdgeInsets.symmetric(horizontal: 20,vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Flag
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Image.asset("assets/flags/${countries[i~/2]}.png",scale: 2),
                ),

                // Country name
                Text(
                  countries[i~/2],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: isOn? i==1? Colors.black: kGrayColor: Colors.white
                  ),
                ),

                // Connection status
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: isOn && i==1?
                  Row(
                    children: [
                      Icon(MaterialCommunityIcons.shield_check_outline,
                        size: 16,
                        color: Color(0xFF1abb1d),
                      ),
                      Text("Connected",
                        style: TextStyle(
                          fontSize: 13,
                          color: Color(0xFF1abb1d),
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  )
                  :Text("Connect",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isOn? Colors.black: Colors.yellow[700]
                    )
                  ),
                )
              ],
            )
          )
        ),
      );

      if(i != list.length-1) list[++i] = SizedBox(width: 10);

    }
    return list;
  }

}
