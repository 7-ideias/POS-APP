import 'package:flutter/material.dart';
import 'package:pos_app/controller/app_controller.dart';
import 'package:pos_app/controller/idioma_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../screens/idioma-tela.dart';
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
      color: AppController.instance.buildThemeData().primaryColor,
      width: MediaQuery.of(context).size.width * 0.8,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            child: imagemDaBarraLateral(context),
          ),
          // opcaoDaBarraLateral(context, 'desenvolvedor', Icons.account_box),
          ListTile(
            leading: const Icon(Icons.people),
            title: Text('meus dados'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.store_mall_directory_sharp),
            title: Text('dados da empresa'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.pan_tool_sharp),
            title: Text('configurações'),
            onTap: () => {Navigator.of(context).pop()},
          ),
          // ListTile(
          //   leading: const Icon(Icons.border_color),
          //   title: Text('Feedback'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
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
                            prefs.remove(VariaveisGlobais.PREFERENCIASDOUSUARIO);
                            setState(() {
                              infoUserService();
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => IdiomaTela()),
                            );
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

Widget imagemDaBarraLateral(BuildContext context) {
  return Container(
    child: UserAccountsDrawerHeader(

      accountName: Text(VariaveisGlobais.usuarioDto.objPessoa!.nome.toString()),
      accountEmail: Text(VariaveisGlobais.usuarioDto.objPessoa!.email.toString().toLowerCase()),
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
    onTap: () {
      Navigator.of(context).pop();
      if (text == 'desenvolvedor') {
        Navigator.of(context).pushNamed('/desenvolvedor');
      }
    },
  );
}
