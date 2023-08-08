import 'package:flutter/material.dart';
import 'package:pos_app/utilitarios/traducao.dart';

import 'VariaveisGlobais.dart';

class MenuLateral extends StatelessWidget {
  MenuLateral(BuildContext context);

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
          opcaoDaBarraLateral(context, 'Clientes', Icons.abc_outlined),
          opcaoDaBarraLateral(context, 'Produtos', Icons.verified_user),
          opcaoDaBarraLateral(context, 'Serviços', Icons.account_box),
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
            onTap: () => {Navigator.of(context).pop()},
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
