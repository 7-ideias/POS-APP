import 'package:flutter/material.dart';
import 'package:pos_app/utilitarios/traducao.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/info-user-service.dart';
import 'VariaveisGlobais.dart';

class MenuLateral extends StatefulWidget {
  MenuLateral(BuildContext context);

  @override
  State<MenuLateral> createState() => _MenuLateralState();
}

class _MenuLateralState extends State<MenuLateral> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            child: imagemDaBarraLateral(context),
          ),
          opcaoDaBarraLateral(
              context,
              Traducao.retornaPalavra("configuração", VariaveisGlobais.idioma),
              Icons.settings),
          opcaoDaBarraLateral(context, 'desenvolvedor', Icons.account_box),
          ListTile(
            leading: const Icon(Icons.border_color),
            title: Text('Feedback'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () async {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirmação de Logout'),
                    content: Text('Tem certeza que deseja fazer logout?'),
                    actions: <Widget>[
                      TextButton(
                        child: Text('Cancelar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text('Confirmar'),
                        onPressed: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          String? jsonString = prefs.getString(
                              VariaveisGlobais.PREFERENCIASDOUSUARIO);
                          if (jsonString != null) {
                            prefs
                                .remove(VariaveisGlobais.PREFERENCIASDOUSUARIO);
                            setState(() {
                              infoUserService();
                            });
                            Navigator.pushReplacementNamed(context, '/login');
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          ListTile(
              // leading: Icon(Icons.star),
              title: Text("Favoritos"),
              subtitle: Text("meus favoritos..."),
              trailing: Icon(Icons.arrow_forward),
              onTap: () {
                debugPrint('toquei no drawer');
              })
        ],
      ),
    );
  }
}

Widget imagemDaBarraLateral(BuildContext context) {
  return Container(
    child: UserAccountsDrawerHeader(
      accountName: Text("nome da conta"),
      accountEmail: Text("carlos@email.com.br"),
      currentAccountPicture: CircleAvatar(
        radius: 30.0,
        backgroundImage: AssetImage('assets/carlosFotoPerfil_laranja.jpg'),
        backgroundColor: Colors.transparent,
      ),
    ),
  );
}

Widget opcaoDaBarraLateral(BuildContext context, String text, IconData icon) {
  return ListTile(
    title: Text(text),
    leading: Icon(icon),
    onTap: () => {
      if (text == 'Clientes')
        {Navigator.of(context).pushNamed('/clientes')}
      else if (text == 'Produtos')
        {Navigator.of(context).pushNamed('/produtos')}
      else if (text == 'Serviços')
        {Navigator.of(context).pushNamed('/servicos')}
      else if (text == 'Settings')
        {Navigator.of(context).pushNamed('/configs')}
      else if (text == 'desenvolvedor')
        {Navigator.of(context).pushNamed('/desenvolvedor')}
    },
  );
}
