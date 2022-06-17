import 'package:sail_app/pages/plan/sliding_cards.dart';
import 'package:flutter/material.dart';

class PlanPage extends StatelessWidget {
  const PlanPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: const <Widget>[
        SlidingCardsView(),
      ],
    );
  }
}
