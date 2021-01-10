import 'package:sail_app/constant/app_urls.dart';
import 'package:sail_app/entity/server_entity.dart';
import 'package:sail_app/utils/http_util.dart';

class ServerService {
  Future<List<ServerEntity>> server() async {
    try {
      var result = await HttpUtil.instance.get(AppUrls.SERVER);

      List<ServerEntity> _serverEntityList = serverEntityFromList(result['data']);

      return _serverEntityList;
    } catch (err) {
      return Future.error(err);
    }
  }
}
