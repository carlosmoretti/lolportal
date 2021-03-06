import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:lolportal/dto/partidas.dto.dart';
import 'package:lolportal/interceptor/token.interceptor.dart';
import 'package:lolportal/service/usuarioConfigurado.service.dart';
import 'package:lolportal/util/api.config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PartidasService {

  Future<List<MatchesDto>> obterPartidas() async {
    var cli = HttpClientWithInterceptor.build(interceptors: [
      TokenInterceptor()
    ]);

    var _usuarioConfiguradoService = UsuarioConfiguradoService();
    var usuarioConfigurado = await _usuarioConfiguradoService.getUsuarioConfigurado();

    String url = ApiConfig.endpoint + "/lol/match/v4/matchlists/by-account/${usuarioConfigurado.accountId}";

    var req = await cli.get(url);
    if(req.statusCode == 200) {
      try {
        List tst = json.decode(req.body)["matches"] as List;
        List<MatchesDto> lista = tst.map((e) => MatchesDto.fromJson(e)).toList();
        return lista;
      } catch(e) {
        print(e);
      }
    }

    return null;
  }

}