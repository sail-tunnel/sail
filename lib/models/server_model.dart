import 'dart:convert';

import 'package:sail_app/constant/app_strings.dart';
import 'package:sail_app/entity/server_entity.dart';
import 'package:sail_app/models/base_model.dart';
import 'package:sail_app/service/server_service.dart';
import 'package:sail_app/utils/shared_preferences_util.dart';

class ServerModel extends BaseModel {
  List<ServerEntity> _serverEntityList;
  ServerEntity _selectServerEntity;
  List<ServerEntity> _selectServerEntityList;

  ServerService _serverService = ServerService();

  List<ServerEntity> get serverEntityList => _serverEntityList;
  ServerEntity get selectServerEntity => _selectServerEntity;
  List<ServerEntity> get selectServerEntityList => _selectServerEntityList;

  getServerList({bool forceRefresh = false}) async {
    bool result = false;

    List<dynamic> data = await SharedPreferencesUtil.getInstance()
            .getList(AppStrings.SERVER_NODE) ??
        List<dynamic>();
    List<dynamic> newData =
        List.from(data.map((e) => Map<String, dynamic>.from(jsonDecode(e))));

    if (newData == null || newData.length == 0 || forceRefresh) {
      setServerEntityList(await _serverService.server());
    } else {
      _serverEntityList = serverEntityFromList(newData);
    }

    notifyListeners();

    result = true;

    return result;
  }

  getSelectServer() async {
    bool result = false;

    Map<String, dynamic> data = await SharedPreferencesUtil.getInstance()
        .getMap(AppStrings.SELECT_SERVER) ?? Map<String, dynamic>();

    _selectServerEntity = ServerEntity.fromMap(data);


    notifyListeners();

    result = true;

    return result;
  }

  getSelectServerList() async {
    bool result = false;

    List<dynamic> data = await SharedPreferencesUtil.getInstance()
        .getList(AppStrings.SELECT_SERVER_NODE) ??
        List<dynamic>();
    List<dynamic> newData =
    List.from(data.map((e) => Map<String, dynamic>.from(jsonDecode(e))));

    _selectServerEntityList = serverEntityFromList(newData);

    notifyListeners();

    result = true;

    return result;
  }

  setServerEntityList(List<ServerEntity> serverEntityList) {
    _serverEntityList = serverEntityList;

    _saveServerEntityList();
  }

  setSelectServerEntityList(List<ServerEntity> selectServerEntityList) {
    _selectServerEntityList = selectServerEntityList;

    _saveSelectServerEntityList();
  }

  setSelectServerEntity(ServerEntity selectServerEntity) {
    _selectServerEntity = selectServerEntity;

    _saveSelectServerEntity();

    notifyListeners();
  }

  _saveServerEntityList() async {
    SharedPreferencesUtil sharedPreferencesUtil =
        SharedPreferencesUtil.getInstance();

    await sharedPreferencesUtil.setList(
        AppStrings.SERVER_NODE, _serverEntityList);
  }

  _saveSelectServerEntity() async {
    SharedPreferencesUtil sharedPreferencesUtil =
        SharedPreferencesUtil.getInstance();

    await sharedPreferencesUtil.setMap(
        AppStrings.SELECT_SERVER, _selectServerEntity.toMap());
  }

  _saveSelectServerEntityList() async {
    SharedPreferencesUtil sharedPreferencesUtil =
    SharedPreferencesUtil.getInstance();

    await sharedPreferencesUtil.setList(
        AppStrings.SELECT_SERVER_NODE, _selectServerEntityList);
  }
}
