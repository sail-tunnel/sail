import 'package:crisp/crisp.dart';
import 'package:flutter/widgets.dart';
import 'package:sail_app/constant/app_strings.dart';

class CrispPage extends StatefulWidget {
  const CrispPage({Key key}) : super(key: key);

  @override
  CrispPageState createState() => CrispPageState();
}

class CrispPageState extends State<CrispPage> {
  CrispMain crispMain;

  @override
  void initState() {
    super.initState();

    crispMain = CrispMain(
      websiteId: AppStrings.crispWebsiteId,
      locale: 'zh-cn',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: CrispView(
      crispMain: crispMain,
      clearCache: false,
    ));
  }
}
