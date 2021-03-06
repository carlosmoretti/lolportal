import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolportal/dto/usuarioConfigurado.dto.dart';
import 'package:lolportal/service/usuarioConfigurado.service.dart';

class UsuarioLogado extends StatefulWidget {
  _UsuarioLogado createState() => _UsuarioLogado();
}

class _UsuarioLogado extends State<UsuarioLogado> {

  final _usuarioLogadoStore = UsuarioConfiguradoService();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: FutureBuilder(
          future: _usuarioLogadoStore.getUsuarioConfigurado(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none || !snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            } else {
              UsuarioConfiguradoDto dto = snapshot.data;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Stack(
                    children: [
                      Image.network(dto.imageIcon,
                        height: 100.0, width: 100.0),
                        Container(
                          margin: EdgeInsets.only(top: 65),
                          width: 100,
                          color: Colors.black54,
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(dto.summonerLevel.toString(), style: TextStyle(
                              fontWeight: FontWeight.bold
                            )),
                          )
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Text(dto.name, style: TextStyle(
                      fontWeight: FontWeight.bold
                    )),
                  ),
                ],
              );
            }
          },
        ),
      );
  }
}