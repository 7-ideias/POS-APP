import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OperacoesTela extends StatefulWidget {
  const OperacoesTela({Key? key}) : super(key: key);

  @override
  State<OperacoesTela> createState() => _OperacoesTelaState();
}

class _OperacoesTelaState extends State<OperacoesTela> {
  @override
  Widget build(BuildContext context) {
    var larguraTela = 0.9;
    var tamanhoDaFonte = 30.0;
    return ListView(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.blueGrey,
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
                          color: Colors.blueGrey,
                        ),
                        Lottie.asset(
                          'assets/astronaut.json',
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
                                        'venda',
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
                onTap: (){
                  Navigator.pushNamed(context, '/venda2');
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
                          color: Colors.green,
                        ),
                        Lottie.asset(
                          'assets/astronaut.json',
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
                                      'ordem \nde \nserviço',
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
                          color: Colors.redAccent,
                        ),
                        Lottie.asset(
                          'assets/astronaut.json',
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
                                      'devolução',
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
    );
  }
}
