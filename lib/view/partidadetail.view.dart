import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lolportal/dto/campeoes.dto.dart';
import 'package:lolportal/dto/partidadetail.dto.dart';
import 'package:lolportal/dto/partidas.dto.dart';
import 'package:lolportal/dto/usuarioConfigurado.dto.dart';
import 'package:lolportal/service/partidadetail.service.dart';
import 'package:lolportal/service/usuarioConfigurado.service.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class PartidaDetail extends StatefulWidget {

  CampeoesDto campeao;
  MatchesDto match;
  List<CampeoesDto> campeosDto;

  PartidaDetail({this.match, this.campeao, this.campeosDto});
  _PartidaDetail createState() => _PartidaDetail();
}

class _PartidaDetail extends State<PartidaDetail> {

  final _partidaDetailService = PartidaDetailService();
  final _usuarioConfiguradoService = UsuarioConfiguradoService();

  final numberFormat = NumberFormat();

  ParticipantIdentities obterParticipante(int participantId, PartidaDetailDto infos)  {
    return infos.participantIdentities.where((element) => element.participantId == participantId).first;
  }

  Stats obterStatsParticipante(int participantId, PartidaDetailDto infos) {
    return infos.participants.where((element) => element.participantId == participantId).first.stats;
  }

  ListView obterJogadores(List<Participants> jogadoresTime1, ParticipantIdentities participante, PartidaDetailDto infos) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: jogadoresTime1.length,
      itemBuilder: (context, i) {
        var item = obterParticipante(jogadoresTime1[i].participantId, infos);
        var stats = obterStatsParticipante(jogadoresTime1[i].participantId, infos);
        var campeaoId = infos.participants.where((element) => element.participantId == jogadoresTime1[i].participantId).first;
        var campeaoInfos = widget.campeosDto.where((element) => int.parse(element.key) == campeaoId.championId).first;

        return ListTile(
          leading: Image.network(campeaoInfos.imagem, width: 50, height: 50),
          tileColor: jogadoresTime1[i].participantId == participante.participantId ? Colors.red : Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.player.summonerName),
              Text("${stats.kills}/${stats.deaths}/${stats.assists}"),
              Text("${stats.totalMinionsKilled} cs"),
          ],),
        );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: FutureBuilder(
        future: Future.wait([_partidaDetailService.obterDetalhePartida(widget.match.gameId), _usuarioConfiguradoService.getUsuarioConfigurado()]),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none || !snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {

            PartidaDetailDto infos = snapshot.data[0];
            UsuarioConfiguradoDto usuarioConfigurado = snapshot.data[1];
            ParticipantIdentities participante = infos.participantIdentities.where((element) => element.player.accountId == usuarioConfigurado.accountId).first;

            int time = infos.participants.where((element) => element.participantId == participante.participantId).first.teamId;
            Stats stats = infos.participants.where((element) => element.participantId == participante.participantId).first.stats;

            int totalDamageGame = infos.participants
              .where((element) => element.teamId == time)
              .map((e) => e.stats.totalDamageDealtToChampions).reduce((a, b) => a + b);

            var jogadoresTime1 = infos.participants.where((element) => element.teamId == time).toList();
            var jogadoresTime2 = infos.participants.where((element) => element.teamId != time).toList();

            return Padding(
              padding: EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(widget.campeao.imagem, height: 100, width: 100)
                      )
                    ),
                  ),
                  Center(
                    child: Text(usuarioConfigurado.name)
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10)
                  ),
                  if(stats.pentaKills > 0)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, size: 12, color: Color(0xFFf39c12)),
                        Text("Penta Kill")
                      ],
                    ),
                  ),
                  if(stats.quadraKills > 0)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.star, size: 12, color: Color(0xFFf39c12)),
                        Text("Quadra Kill")
                      ],
                    ),
                  ),
                  Divider(
                    color: Color(0xFFCCCCCC),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Abates", style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                            Text("${stats.kills}", style: TextStyle(
                              fontSize: 16,
                            ))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Mortes", style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                            Text("${stats.deaths}", style: TextStyle(
                              fontSize: 16,
                            ))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Assistências", style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                            Text("${stats.assists}", style: TextStyle(
                              fontSize: 16
                            ))
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Farm", style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                            Text("${stats.totalMinionsKilled}", style: TextStyle(
                              fontSize: 16
                            ))
                          ],
                        ),
                      ],
                    )
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 15),
                  ),
                  Divider(
                    color: Color(0xFFCCCCCC),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 15)),
                  Text("% de Dano", style: TextStyle(fontWeight: FontWeight.bold)),
                  Text("(Contra inimigos)", style: TextStyle(fontWeight: FontWeight.w100)),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10)
                  ),
                  CircularPercentIndicator(
                    radius: 60.0,
                    lineWidth: 5.0,
                    percent: stats.totalDamageDealtToChampions / totalDamageGame,
                    center: new Text("${((stats.totalDamageDealtToChampions / totalDamageGame) * 100).toStringAsFixed(2)}"),
                    progressColor: Colors.green,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10)
                  ),
                  Text("${stats.totalDamageDealtToChampions}/${totalDamageGame}", style: TextStyle(
                    fontWeight: FontWeight.bold
                  )),
                  Divider(
                    color: Color(0xFFCCCCCC),
                  ),
                  Text("Time Aliado", style: TextStyle(
                    fontWeight: FontWeight.bold
                  )),
                  obterJogadores(jogadoresTime1, participante, infos),
                  Padding(padding: EdgeInsets.only(bottom: 20)),
                  Text("Time Inimigo", style: TextStyle(
                    fontWeight: FontWeight.bold
                  )),
                  obterJogadores(jogadoresTime2, participante, infos),
                ],
              ),
            );
          }
        },
      ),
      )
    );
  }
}