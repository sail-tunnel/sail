import 'package:sail_app/pages/plan/sliding_cards.dart';
import 'package:flutter/material.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('订阅套餐'),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SlidingCardsView(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
