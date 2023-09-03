import 'package:flutter/material.dart';
import 'package:pos_app/screens/preferencias_tela.dart';
import 'package:pos_app/screens/produto-list-tela.dart';
import 'package:pos_app/screens/relatorios_tela.dart';

import '../controller/app_controller.dart';
import '../utilitarios/MenuLateral.dart';
import '../utilitarios/appbar_do_app.dart';

class Index0Tela extends StatefulWidget {
  const Index0Tela({Key? key}) : super(key: key);

  @override
  State<Index0Tela> createState() => _Index0TelaState();
}

class _Index0TelaState extends State<Index0Tela> {
  @override
  Widget build(BuildContext context) {
    var larguraTela = 0.9;
    var tamanhoDaFonte = 22.0;
    return Scaffold(
      appBar: buildAppBar(context),
      drawer: MenuLateral(context),
      backgroundColor: AppController.instance.buildThemeData().primaryColorDark,
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.spaceBetween,
                    children: [
                      //tela produtos
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ProdutosTela()),
                          );
                        },
                        child: Card(
                          elevation: 10,
                          child: Container(
                            color: AppController.instance.buildThemeData().appBarTheme.backgroundColor,
                            height: MediaQuery.of(context).size.width * 0.4,
                            width: MediaQuery.of(context).size.width * larguraTela/2,
                            child: Center(
                                child: Text(
                              'produtos',
                              style: TextStyle(
                                  fontSize: tamanhoDaFonte ),
                            )),
                          ),
                        ),
                      ),
                      //tela clientes
                      GestureDetector(
                        onTap: (){
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => RelatoriosTela()),
                          // );
                        },
                        child: Card(
                          elevation: 10,
                          child: Container(
                            color: AppController.instance.buildThemeData().appBarTheme.backgroundColor,
                            height: MediaQuery.of(context).size.width * 0.4,
                            width: MediaQuery.of(context).size.width * larguraTela/2,
                            child: Center(
                                child: Text(
                                  'clientes',
                                  style: TextStyle(
                                    fontSize: tamanhoDaFonte ),
                                )),
                          ),
                        ),
                      ),
                      //tela colaboradores
                      GestureDetector(
                        onTap: (){
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => RelatoriosTela()),
                          // );
                        },
                        child: Card(
                          elevation: 10,
                          child: Container(
                            color: AppController.instance.buildThemeData().appBarTheme.backgroundColor,
                            height: MediaQuery.of(context).size.width * 0.4,
                            width: MediaQuery.of(context).size.width * larguraTela/2,
                            child: Center(
                                child: Text(
                                  'colaboradores',
                                  style: TextStyle(
                                    fontSize: tamanhoDaFonte ),
                                )),
                          ),
                        ),
                      ),
                      //tela relatorios
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => RelatoriosTela()),
                          );
                        },
                        child: Card(
                          elevation: 10,
                          child: Container(
                            color: AppController.instance.buildThemeData().appBarTheme.backgroundColor,
                            height: MediaQuery.of(context).size.width * 0.4,
                            width: MediaQuery.of(context).size.width * larguraTela/2,
                            child: Center(
                                child: Text(
                                  'relatorios',
                                  style: TextStyle(
                                    fontSize: tamanhoDaFonte ),
                                )),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PreferenciasTela()),
                          );
                        },
                        child: Card(
                          elevation: 10,
                          child: Container(
                            color: AppController.instance.buildThemeData().appBarTheme.backgroundColor,
                            height: MediaQuery.of(context).size.width * 0.4,
                            width: MediaQuery.of(context).size.width * larguraTela/2,
                            child: Center(
                                child: Text(
                                  'preferencias',
                                  style: TextStyle(
                                      fontSize: tamanhoDaFonte ),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }


}
