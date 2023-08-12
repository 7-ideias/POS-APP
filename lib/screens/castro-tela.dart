import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap:() {
                    Navigator.pushNamed(context, '/produtos-geral');
                  },
                  child: Card(
                    elevation: 10,
                    child: Container(
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          'produtos',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: tamanhoDaFonte, color: Colors.white),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'clientes',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: tamanhoDaFonte, color: Colors.white),
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        'colaboradores',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: tamanhoDaFonte, color: Colors.white),
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
              ],
            ),
          )
        ],
      ),
    );
  }
}
