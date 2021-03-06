import 'package:http_interceptor/http_interceptor.dart';
import 'package:lolportal/util/api.config.dart';

class TokenInterceptor implements InterceptorContract {
  
  @override
  Future<RequestData> interceptRequest({RequestData data}) async {
    data.headers["X-Riot-Token"] = ApiConfig.token;
    data.headers["Accept-Charset"] = "application/x-www-form-urlencoded; charset=UTF-8";
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({ResponseData data}) async {
      return data;
  }

}