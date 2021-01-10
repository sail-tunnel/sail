import 'package:sail_app/constant/app_strings.dart';
import 'package:sail_app/entity/server_entity.dart';
import 'package:sail_app/models/base_model.dart';
import 'package:sail_app/service/server_service.dart';
import 'package:sail_app/utils/shared_preferences_util.dart';

class ServerModel extends BaseModel {
  List<ServerEntity> _serverEntityList;

  ServerService _serverService = ServerService();

  List<ServerEntity> get serverEntityList => _serverEntityList;

  Future<bool> getServer() async {
    bool result = false;

    List<ServerEntity> serverEntityList = await _serverService.server();
    setServerEntityList(serverEntityList);

    notifyListeners();

    result = true;

    return result;
  }

  setServerEntityList(List<ServerEntity> serverEntityList) {
    _serverEntityList = serverEntityList;

    _saveServerEntityList();
  }

  _saveServerEntityList() async {
    SharedPreferencesUtil sharedPreferencesUtil = SharedPreferencesUtil.getInstance();

    await sharedPreferencesUtil.setList(AppStrings.USER_INFO, _serverEntityList);
  }
}
