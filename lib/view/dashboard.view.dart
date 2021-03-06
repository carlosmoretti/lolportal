import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lolportal/dto/usuarioConfigurado.dto.dart';
import 'package:lolportal/service/usuarioConfigurado.service.dart';
import 'package:lolportal/view/ultimosgames.view.dart';
import 'package:lolportal/view/usuariologado.view.dart';

class Dashboard extends StatefulWidget {
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {

  final _usuarioLogadoStore = UsuarioConfiguradoService();
  
  int paginaSelecionada = 0;
  final List<Widget> _telas = [
    UsuarioLogado(),
    UltimosGames()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(icon: Icon(Icons.exit_to_app), onPressed: () async {
            await _usuarioLogadoStore.setUsuarioConfigurado(null);
            Navigator.of(context).pushReplacementNamed("/config");
          })
        ],
      ),
      body: _telas[paginaSelecionada],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: paginaSelecionada,
        onTap: (e) {
          setState(() {
            paginaSelecionada = e;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Minha Conta",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_basket),
              label: "Meus Jogos"
          ),
        ],
      ),
    );
  }
}