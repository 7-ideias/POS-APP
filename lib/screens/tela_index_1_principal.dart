import 'package:flutter/material.dart';
import 'package:pos_app/controller/app_controller.dart';
import 'package:pos_app/utilitarios/shake-icon.dart';

import '../utilitarios/Donut.dart';
import '../utilitarios/MenuLateral.dart';
import '../utilitarios/VariaveisGlobais.dart';
import '../utilitarios/appbar_do_app.dart';

class Index1Tela extends StatefulWidget {
  @override
  _Index1TelaState createState() => _Index1TelaState();
}

class _Index1TelaState extends State<Index1Tela>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isExpanded = false;
  final GlobalKey keyContainer = GlobalKey();

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppController.instance.corTelaFundo,
      appBar: buildAppBar(context),
      drawer: MenuLateral(context),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                child: Icon(Icons.refresh),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
      body: ListView(children: [
        Stack(
          children: [
            Container(
              key: keyContainer,
              color: AppController.instance.corTelaFundo,
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.35,
              child: Container(
                alignment: Alignment.bottomLeft,
                child: Container(
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 20),
                              Text('Ola 😊',
                                  style: TextStyle(
                                      color: AppController.instance.corLetras,
                                      fontSize: 15)),
                            ],
                          ),
                          SizedBox(width: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 20),
                              Text(
                                VariaveisGlobais
                                        .usuarioDto.objUser?.objPessoa?.nome ??
                                    '',
                                style: TextStyle(
                                  color: AppController.instance.corLetras,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 80,
                  ),
                  Card(
                    color: AppController.instance.corTelaAcima,
                    elevation: 10,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.3,
                      width: MediaQuery.of(context).size.width * 0.88,
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, '/operacoes');
                                    },
                                    child: ShakeIcon(
                                        icon: Icon(
                                            color: AppController
                                                .instance.corLetras,
                                            size: 50,
                                            Icons.shopping_cart)),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: ShakeIcon(
                                      icon: Icon(
                                          color:
                                              AppController.instance.corLetras,
                                          size: 50,
                                          Icons.monetization_on)),
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
          ],
        ),
        SizedBox(height: 20),
        SizedBox(height: 20),
        _isExpanded
            ? Container()
            : Card(
                color: AppController.instance.corTelaAcima,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('DIA',
                          style: TextStyle(
                            fontSize: 22,
                            color: AppController.instance.corLetras,
                          )),
                    ),
                    Donut(context),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 20),
                      child: ResumoTable(),
                    ),
                  ],
                )),
        _isExpanded
            ? Container()
            : Card(
                color: AppController.instance.corTelaAcima,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('MÊS',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppController.instance.corLetras,
                          )),
                    ),
                    Donut(context),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 20),
                      child: ResumoTable(),
                    ),
                  ],
                )),
        _isExpanded
            ? Container()
            : Card(
                color: AppController.instance.corTelaAcima,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('resumo do dia',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppController.instance.corLetras,
                          )),
                    ),
                    Donut(context),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10, left: 10, right: 10, bottom: 20),
                      child: ResumoTable(),
                    ),
                  ],
                )),
      ]),
    );
  }


  double height() => 30;
}

Table ResumoTable() {
  return Table(
      border: TableBorder.all(
        color: AppController.instance.corLetras,
      ),
      children: [
        TableRow(
          children: [
            TableCell(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                child: Text('operação',
                    style: TextStyle(
                        color: AppController.instance.corLetras,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
            ),
            TableCell(
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(8),
                child: Text('valor do dia',
                    style: TextStyle(
                        color: AppController.instance.corLetras,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Text('vendas',
                    style: TextStyle(
                        color: AppController.instance.corLetras,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
            ),
            TableCell(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Text('R\$ 1200,00',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: AppController.instance.corLetras,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
            ),
          ],
        ),
        TableRow(
          children: [
            TableCell(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Text('orçamentos',
                    style: TextStyle(
                        color: AppController.instance.corLetras,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
            ),
            TableCell(
              child: Container(
                padding: EdgeInsets.all(8),
                child: Text('R\$ 1200,00',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        color: AppController.instance.corLetras,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
            ),
          ],
        ),
      ]);
}
