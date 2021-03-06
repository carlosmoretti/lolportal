import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lolportal/dto/campeoes.dto.dart';
import 'package:lolportal/dto/partidas.dto.dart';
import 'package:lolportal/service/campeoes.service.dart';
import 'package:lolportal/service/partidas.service.dart';
import 'package:lolportal/view/partidadetail.view.dart';

class UltimosGames extends StatefulWidget {
  _UltimosGames createState() => _UltimosGames();
}

class _UltimosGames extends State<UltimosGames> {

  final _campeoesService = CampeoesService();
  final _partidasService = PartidasService();

  var df = DateFormat('dd/MM/yyyy');

  Future<List<MatchesDto>> _futurePartidas;
  
  List<CampeoesDto> campeosDto = new List<CampeoesDto>();

  @override
  void initState() {
    super.initState();
    campeosDto = List();
    _futurePartidas = _partidasService.obterPartidas();

    _campeoesService.obterCampeoes().then((value) => {
      this.campeosDto = value
    });
  }

  void obterPartidas() {
    _futurePartidas = _partidasService.obterPartidas();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = 
    new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Center(child: FutureBuilder(
      future: _futurePartidas,
      builder: (context, snapshot) {
        if((snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none || !snapshot.hasData)) {
          return Center(child: CircularProgressIndicator());
        } else {
          return RefreshIndicator(child: ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, i) {
              MatchesDto dto = snapshot.data[i];
              var imagemCampeao = campeosDto.where((element) => int.parse(element.key) == dto.champion).first;

              return ListTile(
                leading: Image.network(imagemCampeao.imagem, height: 35, width: 35),
                trailing: IconButton(icon: Icon(Icons.arrow_right), onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PartidaDetail(
                    campeao: imagemCampeao,
                    match: dto,
                    campeosDto: campeosDto,
                  )));
                }),
                title: Text(imagemCampeao.name),
                subtitle: Text("${dto.platformId} | ${df.format(DateTime.fromMicrosecondsSinceEpoch(dto.timestamp * 1000))}"),
              );
            },
          ), onRefresh: () {
            setState(() {
              _futurePartidas = _partidasService.obterPartidas();
            });
          });
        }
      },
    ));
  }
}