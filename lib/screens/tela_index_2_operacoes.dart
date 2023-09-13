import 'package:flutter/material.dart';

import '../controller/app_controller.dart';
import '../utilitarios/MenuLateral.dart';
import '../utilitarios/appbar_do_app.dart';
import 'caixa_tela.dart';
import 'devolucao_tela.dart';
import 'operacao-list-tela.dart';

class Index2Tela extends StatefulWidget {
  const Index2Tela({Key? key}) : super(key: key);

  @override
  State<Index2Tela> createState() => _Index2TelaState();
}

class _Index2TelaState extends State<Index2Tela> {
  @override
  Widget build(BuildContext context) {
    var larguraTela = 0.9;
    var tamanhoDaFonte = 22.0;
    return Scaffold(
      backgroundColor: AppController.instance.buildThemeData().primaryColorDark,
      appBar: buildAppBar(context),
      drawer: MenuLateral(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  direction: Axis.horizontal,
                  children: [
                    //caixa
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CaixaTela()),
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
                                'caixa',
                                style: TextStyle(
                                  fontSize: tamanhoDaFonte ),
                              )),
                        ),
                      ),
                    ),
                    //vendas
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const OperacaoTela()),
                        );
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                          color: AppController.instance.buildThemeData().appBarTheme.backgroundColor,
                          height: MediaQuery.of(context).size.width * 0.4,
                          width: MediaQuery.of(context).size.width * larguraTela/2,
                          child: Center(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'vendas e\nservicos ',
                                  style: TextStyle(
                                    fontSize: tamanhoDaFonte)
                                ),
                              )),
                        ),
                      ),
                    ),
                    //devolucao
                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const DevolucaoTela()),
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
                                'devolução',
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
        ),
    );
  }

}
