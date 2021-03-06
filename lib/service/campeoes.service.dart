import 'package:lolportal/dto/campeoes.dto.dart';
import 'package:http/http.dart' as http;
import 'package:lolportal/service/lolconfig.service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CampeoesService {
  Future<List<CampeoesDto>> obterCampeoes() async {

    var _configService = LolConfigService();
    String versao = await _configService.getLolConfig();

    var req = await http.get("http://ddragon.leagueoflegends.com/cdn/${versao}/data/pt_BR/champion.json");
    if(req.statusCode == 200) {
      print(req.body);
      Map<String, dynamic> lista = json.decode(req.body)["data"];
 
      print("pegou os res");

      List<CampeoesDto> dto = List();
      lista.forEach((key, value) {
        var item = CampeoesDto.fromJson(value);
        String imagem = value["image"]["full"];
        item.imagem = "http://ddragon.leagueoflegends.com/cdn/${versao}/img/champion/${imagem}";
        dto.add(item);
      });

      return dto;
    }

    return null;
  }
}