import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class FinanceiroTela extends StatefulWidget {
  const FinanceiroTela({Key? key}) : super(key: key);

  @override
  State<FinanceiroTela> createState() => _FinanceiroTelaState();
}

class _FinanceiroTelaState extends State<FinanceiroTela> {
  @override
  Widget build(BuildContext context) {
    var larguraTela = 0.9;
    var tamanhoDaFonte = 30.0;
    return ListView(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.orange,
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
                                        'caixa',
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
                onTap: () {
                  Navigator.pushNamed(context, '/caixa');
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  direction: Axis.horizontal,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/cadastros');
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                          color: Colors.blueGrey,
                          height: MediaQuery.of(context).size.width * 0.4,
                          width: MediaQuery.of(context).size.width * larguraTela/2,
                          child: Center(
                              child: Text(
                            'cadastros',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: tamanhoDaFonte, color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, '/relatorios');
                      },
                      child: Card(
                        elevation: 10,
                        child: Container(
                          color: Colors.blueGrey,
                          height: MediaQuery.of(context).size.width * 0.4,
                          width: MediaQuery.of(context).size.width * larguraTela/2,
                          child: Center(
                              child: Text(
                            'relatórios',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: tamanhoDaFonte, color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                    GestureDetector(
                      child: Card(
                        elevation: 10,
                        child: Container(
                          color: Colors.blueGrey,
                          height: MediaQuery.of(context).size.width * 0.4,
                          width: MediaQuery.of(context).size.width * larguraTela/2,
                          child: Center(
                              child: Text(
                            'configs',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: tamanhoDaFonte, color: Colors.white),
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
    );
  }
}
