import 'package:sail/constant/app_urls.dart';
import 'package:sail/entity/server_entity.dart';
import 'package:sail/utils/http_util.dart';

class ServerService {
  Future<List<ServerEntity>>? server() {
    return HttpUtil.instance?.get(AppUrls.server).then((result) {
      return serverEntityFromList(result['data']);
    });
  }
}
