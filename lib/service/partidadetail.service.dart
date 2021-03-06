import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:lolportal/dto/partidadetail.dto.dart';
import 'package:lolportal/interceptor/token.interceptor.dart';
import 'package:lolportal/util/api.config.dart';
import 'dart:convert';

class PartidaDetailService {
  Future<PartidaDetailDto> obterDetalhePartida(int matchId) async {
    var cli = HttpClientWithInterceptor.build(interceptors: [
      TokenInterceptor()
    ]);

    var req = await cli.get(ApiConfig.endpoint + "/lol/match/v4/matches/${matchId}");
    if(req.statusCode == 200) {
      print(req.body);
      PartidaDetailDto dto = PartidaDetailDto.fromJson(json.decode(req.body)); 

      return dto;
    }

    return null;
  }
}