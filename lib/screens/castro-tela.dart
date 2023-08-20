import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_app/screens/produto-list-tela.dart';

import '../controller/app_controller.dart';

class CadastrosTela extends StatefulWidget {
  const CadastrosTela({Key? key}) : super(key: key);

  @override
  State<CadastrosTela> createState() => _CadastrosTelaState();
}

class _CadastrosTelaState extends State<CadastrosTela> {
  @override
  Widget build(BuildContext context) {
    var larguraTela = 0.9;
    var tamanhoDaFonte = 30.0;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: AppController.instance.corTelaFundo,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap:() {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProdutosTela()),
                );
              },
              child: Card(
                elevation: 10,
                child: Container(
                  color: AppController.instance.corTelaAcima,
                  height: 200,
                  width: MediaQuery.of(context).size.width * larguraTela,
                  child: Stack(
                    children: [
                      Container(
                      ),
                      Lottie.asset(
                        'assets/produtos.json',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'produtos',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: tamanhoDaFonte, color: Colors.black),
                                      ),
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
            ),
            GestureDetector(
              child: Card(
                elevation: 10,
                child: Container(
                  color: AppController.instance.corTelaAcima,
                  height: 200,
                  width: MediaQuery.of(context).size.width * larguraTela,
                  child: Stack(
                    children: [
                      Container(
                      ),
                      Lottie.asset(
                        'assets/clientes.json',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'clientes',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: tamanhoDaFonte, color: Colors.black),
                                      ),
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
            ),
            GestureDetector(
              child: Card(
                elevation: 10,
                child: Container(
                  color: AppController.instance.corTelaAcima,
                  height: 200,
                  width: MediaQuery.of(context).size.width * larguraTela,
                  child: Stack(
                    children: [
                      Container(
                      ),
                      Lottie.asset(
                        'assets/agency-team.json',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'produtos',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: tamanhoDaFonte, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
