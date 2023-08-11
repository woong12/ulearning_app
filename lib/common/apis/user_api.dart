import 'package:ulearning_app/common/entities/user.dart';

import '../utils/http_util.dart';

class UserAPI {
  static login(
      {LoginRequestEntity? params, required LoginRequestEntity param}) async {
    var response = await HttpUtil().post(
      'api/login',
      queryParameters: params?.toJson(),
    );
    print(response.toString());
  }
}
