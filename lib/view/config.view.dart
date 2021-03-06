import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolportal/service/lolconfig.service.dart';
import 'package:lolportal/service/usuario.service.dart';
import 'package:lolportal/service/usuarioConfigurado.service.dart';

class Config extends StatefulWidget {
  _ConfigState createState() => _ConfigState();
}

class _ConfigState extends State<Config> {

  final _controllerNomeUsuario = TextEditingController();
  final _usuarioService = UsuarioService();
  final _usuarioConfiguradoService = UsuarioConfiguradoService();

  final _lolConfigService = LolConfigService();

  @override
  void initState() {
    super.initState();

    _lolConfigService.setLolConfig().then((value) => {
      _usuarioConfiguradoService.getUsuarioConfigurado().then((value) => {
        if(value != null) {
          Navigator.pushReplacementNamed(context, "/dashboard")
        }
      })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Informe o nome do seu campeão:"),
              TextFormField(
                textAlign: TextAlign.center,
                controller: _controllerNomeUsuario,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  filled: true
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: RaisedButton(
                // color: Colors.red,
                  child: Text("Confirmar"),
                  onPressed: () async {
                    var res = await _usuarioService.buscarUsuario(_controllerNomeUsuario.text);
                    _usuarioConfiguradoService.setUsuarioConfigurado(res);
                    Navigator.of(context).pushReplacementNamed("/dashboard");
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}