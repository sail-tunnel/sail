import 'dart:convert';
import 'dart:io';

import 'package:sail_app/constant/app_strings.dart';
import 'package:sail_app/entity/server_entity.dart';
import 'package:sail_app/models/base_model.dart';
import 'package:sail_app/service/server_service.dart';
import 'package:sail_app/utils/shared_preferences_util.dart';
import 'package:sail_app/utils/common_util.dart';

class ServerModel extends BaseModel {
  List<ServerEntity> _serverEntityList;
  ServerEntity _selectServerEntity;
  List<ServerEntity> _selectServerEntityList;

  final ServerService _serverService = ServerService();

  List<ServerEntity> get serverEntityList => _serverEntityList;

  ServerEntity get selectServerEntity => _selectServerEntity;

  List<ServerEntity> get selectServerEntityList => _selectServerEntityList;

  getServerList({bool forceRefresh = false}) async {
    bool result = false;

    List<dynamic> data = await SharedPreferencesUtil.getInstance().getList(AppStrings.serverNode) ?? [];
    List<dynamic> newData = List.from(data.map((e) => Map<String, dynamic>.from(jsonDecode(e))));

    if (newData == null || newData.isEmpty || forceRefresh) {
      setServerEntityList(await _serverService.server());
    } else {
      _serverEntityList = serverEntityFromList(newData);
    }

    notifyListeners();

    result = true;

    return result;
  }

  Future<Duration> ping(int index) {
    ServerEntity serverEntity = _serverEntityList[index];
    String host = serverEntity.host;
    int serverPort = serverEntity.port;

    print("host=$host");
    print("serverPort=$serverPort");

    Stopwatch stopwatch = Stopwatch()..start();

    return Socket.connect(host, serverPort, timeout: const Duration(seconds: 3)).then((socket) {
      socket.first.then((value) {
        print("value=$value");
      });
      var duration = stopwatch.elapsed;
      print("duration=${duration.inMilliseconds}");
      print("socket.address=${socket.address}");
      print("socket.port=${socket.port}");
      _serverEntityList[index].ping = duration;

      notifyListeners();

      return duration;
    }).catchError((error) {
      var duration = stopwatch.elapsed;
      print("duration=${duration.inMilliseconds}");
      print("error=${error.toString()}");
      _serverEntityList[index].ping = duration;

      notifyListeners();

      return duration;
    });
  }

  getSelectServer() async {
    bool result = false;

    Map<String, dynamic> data =
        await SharedPreferencesUtil.getInstance().getMap(AppStrings.selectServer) ?? <String, dynamic>{};

    _selectServerEntity = ServerEntity.fromMap(data);

    notifyListeners();

    result = true;

    return result;
  }

  getSelectServerList() async {
    bool result = false;

    List<dynamic> data = await SharedPreferencesUtil.getInstance().getList(AppStrings.selectServerNode) ?? [];
    List<dynamic> newData = List.from(data.map((e) => Map<String, dynamic>.from(jsonDecode(e))));

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
    SharedPreferencesUtil sharedPreferencesUtil = SharedPreferencesUtil.getInstance();

    await sharedPreferencesUtil.setList(AppStrings.serverNode, _serverEntityList);
  }

  _saveSelectServerEntity() async {
    SharedPreferencesUtil sharedPreferencesUtil = SharedPreferencesUtil.getInstance();

    await sharedPreferencesUtil.setMap(AppStrings.selectServer, _selectServerEntity.toMap());
  }

  _saveSelectServerEntityList() async {
    SharedPreferencesUtil sharedPreferencesUtil = SharedPreferencesUtil.getInstance();

    await sharedPreferencesUtil.setList(AppStrings.selectServerNode, _selectServerEntityList);
  }
}
