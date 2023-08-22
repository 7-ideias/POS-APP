import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_app/screens/caixa_tela.dart';
import 'package:pos_app/screens/produto-list-tela.dart';
import 'package:pos_app/screens/relatorios_tela.dart';

import '../controller/app_controller.dart';
import '../utilitarios/MenuLateral.dart';
import '../utilitarios/VariaveisGlobais.dart';
import '../utilitarios/appbar_do_app.dart';
import 'castro-tela.dart';

class FinanceiroTela extends StatefulWidget {
  const FinanceiroTela({Key? key}) : super(key: key);

  @override
  State<FinanceiroTela> createState() => _FinanceiroTelaState();
}

class _FinanceiroTelaState extends State<FinanceiroTela> {
  @override
  Widget build(BuildContext context) {
    var larguraTela = 0.9;
    var tamanhoDaFonte = 22.0;
    return Scaffold(
      appBar: buildAppBar(context),
      drawer: MenuLateral(context),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            color: AppController.instance.corTelaFundo,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  child: Card(
                    elevation: 10,
                    child: Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width * larguraTela,
                      child: Stack(
                        children: [
                          Container(
                            color: AppController.instance.corTelaAcima,
                          ),
                          Lottie.asset(
                            'assets/financial-accounting.json',
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.5,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          'caixa',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: tamanhoDaFonte, color: AppController.instance.corLetras),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CaixaTela()),
                    );
                  },
                ),
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
                            color: AppController.instance.corTelaAcima,
                            height: MediaQuery.of(context).size.width * 0.4,
                            width: MediaQuery.of(context).size.width * larguraTela/2,
                            child: Center(
                                child: Text(
                              'produtos',
                              style: TextStyle(
                                  fontSize: tamanhoDaFonte, color: AppController.instance.corLetras,),
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
                            color: AppController.instance.corTelaAcima,
                            height: MediaQuery.of(context).size.width * 0.4,
                            width: MediaQuery.of(context).size.width * larguraTela/2,
                            child: Center(
                                child: Text(
                                  'clientes',
                                  style: TextStyle(
                                    fontSize: tamanhoDaFonte, color: AppController.instance.corLetras,),
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
                            color: AppController.instance.corTelaAcima,
                            height: MediaQuery.of(context).size.width * 0.4,
                            width: MediaQuery.of(context).size.width * larguraTela/2,
                            child: Center(
                                child: Text(
                                  'colaboradores',
                                  style: TextStyle(
                                    fontSize: tamanhoDaFonte, color: AppController.instance.corLetras,),
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
                            color: AppController.instance.corTelaAcima,
                            height: MediaQuery.of(context).size.width * 0.4,
                            width: MediaQuery.of(context).size.width * larguraTela/2,
                            child: Center(
                                child: Text(
                                  'relatorios',
                                  style: TextStyle(
                                    fontSize: tamanhoDaFonte, color: AppController.instance.corLetras,),
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
