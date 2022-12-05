import 'package:sail_app/entity/plan_entity.dart';
import 'package:sail_app/models/base_model.dart';
import 'package:sail_app/service/plan_service.dart';

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
