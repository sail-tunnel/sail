import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:math' as math;

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sail_app/entity/plan_entity.dart';
import 'package:sail_app/service/plan_service.dart';

class SlidingCardsView extends StatefulWidget {
  @override
  _SlidingCardsViewState createState() => _SlidingCardsViewState();
}

class _SlidingCardsViewState extends State<SlidingCardsView> {
  PageController pageController;
  double pageOffset = 0;
  List<PlanEntity> _planEntityList = List<PlanEntity>();

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
    pageController.addListener(() {
      setState(() => pageOffset = pageController.page);
    });

    PlanService().plan().then((planEntityList) {
      setState(() {
        _planEntityList = planEntityList;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.55,
      child: PageView(
          controller: pageController,
          children: List.from(_planEntityList.map((e) => SlidingCard(
              name: e.name,
              date: e.createdAt.toIso8601String(),
              onetimePrice: (e.onetimePrice ?? 0.0) / 100,
              monthPrice: (e.monthPrice ?? 0.0) / 100,
              quarterPrice: (e.quarterPrice ?? 0.0) / 100,
              halfYearPrice: (e.halfYearPrice ?? 0.0) / 100,
              yearPrice: (e.yearPrice ?? 0.0) / 100,
              twoYearPrice: (e.twoYearPrice) ?? 0.0 / 100,
              threeYearPrice: (e.threeYearPrice) ?? 0.0 / 100,
              assetName: 'steve-johnson.jpeg',
              offset: pageOffset)))),
    );
  }
}

class SlidingCard extends StatelessWidget {
  final String name;
  final String date;
  final String assetName;
  final double offset;
  final double onetimePrice;
  final double monthPrice;
  final double quarterPrice;
  final double halfYearPrice;
  final double yearPrice;
  final double twoYearPrice;
  final double threeYearPrice;

  const SlidingCard({
    Key key,
    @required this.name,
    @required this.date,
    @required this.assetName,
    @required this.offset,
    @required this.onetimePrice,
    @required this.monthPrice,
    @required this.quarterPrice,
    @required this.halfYearPrice,
    @required this.yearPrice,
    @required this.twoYearPrice,
    @required this.threeYearPrice,
  }) : super(key: key);

  double lowestPrice() {
    List<double> list = [
      this.onetimePrice,
      this.monthPrice,
      this.quarterPrice,
      this.halfYearPrice,
      this.yearPrice,
      this.twoYearPrice,
      this.threeYearPrice,
    ];

    double min;

    for (int i = 0; i < list.length; i++) {
      if ((min == null || list[i] < min) && list[i] > 0) {
        min = list[i];
      }
    }

    return min;
  }

  @override
  Widget build(BuildContext context) {
    double gauss = math.exp(-(math.pow((offset.abs() - 0.5), 2) / 0.08));
    return Transform.translate(
      offset: Offset(-32 * gauss * offset.sign, 0),
      child: Card(
        margin: EdgeInsets.only(left: 8, right: 8, bottom: 24),
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              child: Image.asset(
                'assets/$assetName',
                height: MediaQuery.of(context).size.height * 0.3,
                alignment: Alignment(-offset.abs(), 0),
                fit: BoxFit.none,
              ),
            ),
            SizedBox(height: 8),
            Expanded(
              child: CardContent(
                name: name,
                date: date,
                offset: gauss,
                lowestPrice: lowestPrice(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardContent extends StatelessWidget {
  final String name;
  final String date;
  final double offset;
  final double lowestPrice;

  const CardContent(
      {Key key,
      @required this.name,
      @required this.date,
      @required this.offset,
      @required this.lowestPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Transform.translate(
            offset: Offset(8 * offset, 0),
            child: Text(name, style: TextStyle(fontSize: 20)),
          ),
          SizedBox(height: 8),
          Transform.translate(
            offset: Offset(32 * offset, 0),
            child: Text(
              date,
              style: TextStyle(color: Colors.grey),
            ),
          ),
          Spacer(),
          Row(
            children: <Widget>[
              Transform.translate(
                offset: Offset(48 * offset, 0),
                child: RaisedButton(
                  color: Colors.yellow,
                  child: Transform.translate(
                    offset: Offset(24 * offset, 0),
                    child: Text('购买',
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: ScreenUtil().setSp(36))),
                  ),
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                  onPressed: () {},
                ),
              ),
              Spacer(),
              Transform.translate(
                offset: Offset(32 * offset, 0),
                child: Text(
                  '¥ $lowestPrice 起',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(width: 16),
            ],
          )
        ],
      ),
    );
  }
}
