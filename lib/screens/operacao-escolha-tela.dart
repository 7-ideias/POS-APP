import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OperacaoEscolhaTela extends StatefulWidget {
  const OperacaoEscolhaTela({Key? key}) : super(key: key);

  @override
  State<OperacaoEscolhaTela> createState() => _OperacaoEscolhaTelaState();
}

class _OperacaoEscolhaTelaState extends State<OperacaoEscolhaTela> {
  @override
  Widget build(BuildContext context) {
    var larguraTela = 0.9;
    var tamanhoDaFonte = 30.0;
    return buildListView(context, larguraTela, tamanhoDaFonte);
  }

  Widget buildListView(BuildContext context, double larguraTela, double tamanhoDaFonte) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.blue[900],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
                    Lottie.asset('assets/vendedor.json',
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
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Card(
                                  elevation: 10,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            'vendas',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: tamanhoDaFonte, color: Colors.blue[900]),
                                          ),
                                          Text(
                                            'e',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: tamanhoDaFonte, color: Colors.blue[900]),
                                          ),
                                          Text(
                                            'serviços',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: tamanhoDaFonte, color: Colors.blue[900]),
                                          ),
                                        ],
                                      ),
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
            onTap: (){
              Navigator.pushNamed(context, '/operacoes');
            },
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
                      'assets/return-package.json',
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
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Card(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        'devolução',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontSize: tamanhoDaFonte, color: Colors.blue[900]),
                                      ),
                                    ),
                                  ),
                                  elevation: 10,
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
            onTap: (){
              Navigator.pushNamed(context, '/devolucao');
            },
          ),
        ],
      ),
    );
  }
}
