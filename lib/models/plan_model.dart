import 'package:sail/entity/plan_entity.dart';
import 'package:sail/models/base_model.dart';
import 'package:sail/service/plan_service.dart';

class PlanModel extends BaseModel {
  final PlanService _planService = PlanService();

  List<PlanEntity> _planEntityList = [];

  List<PlanEntity> get planEntityList => _planEntityList;

  // 获取套餐列表
  void fetchPlanList() async {
    _planEntityList = (await _planService.plan())!;

    notifyListeners();
  }
}
