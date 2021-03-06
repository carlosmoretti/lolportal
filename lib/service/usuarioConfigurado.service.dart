import 'package:lolportal/dto/usuarioConfigurado.dto.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UsuarioConfiguradoService {
  setUsuarioConfigurado(UsuarioConfiguradoDto dto) async {
    final _sharedPrefs = await SharedPreferences.getInstance();
    await _sharedPrefs.setString("usuarioLogado", json.encode(dto));
  }

  Future<UsuarioConfiguradoDto> getUsuarioConfigurado() async {
    print("Entrou aqui");
    final _sharedPrefs = await SharedPreferences.getInstance();
    var usuarioLogado = UsuarioConfiguradoDto.fromJson(json.decode(_sharedPrefs.get("usuarioLogado")));
    String versaoLol = await _sharedPrefs.get("lolVersion");

    usuarioLogado.imageIcon = "https://ddragon.leagueoflegends.com/cdn/${versaoLol}/img/profileicon/${usuarioLogado.profileIconId}.png";
    return usuarioLogado;
  }
}