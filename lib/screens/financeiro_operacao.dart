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
    var tamanhoDaFonte = 22.0;
    return ListView(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          color: Colors.indigoAccent,
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
                          color: Colors.blueGrey.shade500,
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
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        color: Colors.blueGrey,
                        ),
                        height: MediaQuery.of(context).size.width * 0.4,
                        width: MediaQuery.of(context).size.width * larguraTela/2,
                        child: Stack(
                          children: [
                            Lottie.asset('assets/relatorios.json'),
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10), // Define o raio das bordas arredondadas
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    'relatórios',
                                    style: TextStyle(
                                      fontSize: tamanhoDaFonte,
                                      // color: Colors.black12,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
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
