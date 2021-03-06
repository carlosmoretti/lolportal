import 'package:http_interceptor/http_client_with_interceptor.dart';
import 'package:lolportal/dto/usuarioConfigurado.dto.dart';
import 'package:lolportal/interceptor/token.interceptor.dart';
import 'package:lolportal/util/api.config.dart';
import 'dart:convert';

class UsuarioService {
  final endpoint = ApiConfig.endpoint;

  Future<UsuarioConfiguradoDto> buscarUsuario(String username) async {
    var cli = HttpClientWithInterceptor.build(interceptors: [
      TokenInterceptor()
    ]);

    var res = await cli.get("${endpoint}/lol/summoner/v4/summoners/by-name/${username}");
    if(res.statusCode == 200) {
      UsuarioConfiguradoDto dto = UsuarioConfiguradoDto.fromJson(json.decode(res.body));
      return dto;
    } else {
      return null;
    }
  }
}