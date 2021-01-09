import 'package:sail_app/constant/app_urls.dart';
import 'package:sail_app/entity/plan_entity.dart';
import 'package:sail_app/utils/http_util.dart';

class PlanService {
  Future<List<PlanEntity>> plan() async {
    try {
      var result = await HttpUtil.instance.get(AppUrls.PLAN);

      List<PlanEntity> _planEntityList = planEntityFromList(result['data']);

      return _planEntityList;
    } catch (err) {
      return Future.error(err);
    }
  }
}
