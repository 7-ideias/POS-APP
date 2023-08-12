import 'package:flutter/material.dart';
import 'package:pos_app/screens/others/shake-icon.dart';

import '../../utilitarios/Donut.dart';
import '../../utilitarios/MenuLateral.dart';
import '../../utilitarios/VariaveisGlobais.dart';

class PrincipalTela extends StatefulWidget {
  @override
  _PrincipalTelaState createState() => _PrincipalTelaState();
}

class _PrincipalTelaState extends State<PrincipalTela>
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
      backgroundColor: Colors.indigo,
      appBar: AppBar(
        title: Text(VariaveisGlobais.NOME_SISTEMA),
      ),
      drawer: MenuLateral(context),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // SizedBox(height: 16),
          // if (_isExpanded)
          //   Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Container(
          //         child: Card(
          //           elevation: 3,
          //           child: Text('nova venda',
          //               style: TextStyle(fontSize: 30, color: Colors.indigo)),
          //         ),
          //       ),
          //       SizedBox(
          //         width: 20,
          //       ),
          //       buildFloatingActionButton(
          //         icon: Icons.add,
          //         onPressed: () {
          //           Navigator.pushNamed(context, '/venda');
          //         },
          //       ),
          //     ],
          //   ),
          // SizedBox(height: 16),
          // if (_isExpanded) SizedBox(height: 16),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     _isExpanded
          //         ? Container(
          //             child: Card(
          //               elevation: 3,
          //               child: Text('cancelar',
          //                   style:
          //                       TextStyle(fontSize: 30, color: Colors.indigo)),
          //             ),
          //           )
          //         : Container(),
          //     SizedBox(
          //       width: 20,
          //     ),
          //     buildFloatingActionButton(
          //       icon: _isExpanded ? Icons.close : Icons.add,
          //       onPressed: () {
          //         setState(() {
          //           _isExpanded = !_isExpanded;
          //           _isExpanded
          //               ? _animationController.forward()
          //               : _animationController.reverse();
          //         });
          //       },
          //     ),
          //   ],
          // ),
          // SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              buildFloatingActionButton(
                icon: Icons.refresh,
                onPressed: () {
                  //todo
                },
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
              color: Colors.indigo,
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
                              Text('Boa tarde',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15)),
                            ],
                          ),
                          SizedBox(width: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 20),
                              Text('Nome do Usuário',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
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
                    color: Colors.indigoAccent,
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
                                    onTap: (){
                                      Navigator.pushNamed(context, '/venda2');
                                    },
                                    child: ShakeIcon(icon: Icon(
                                        color: Colors.yellow,
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
                                  child: ShakeIcon(icon: Icon(
                                      color: Colors.yellow,
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
                color: Colors.indigoAccent,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('DIA',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
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
                color: Colors.indigoAccent,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('MÊS',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
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
                color: Colors.indigoAccent,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('resumo do dia',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
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

  Widget buildFloatingActionButton(
      {required IconData icon, required VoidCallback onPressed}) {
    return FloatingActionButton(
      child: Icon(icon),
      onPressed: onPressed,
    );
  }
}

Table ResumoTable() {
  return Table(border: TableBorder.all(color: Colors.white), children: [
    TableRow(
      children: [
        TableCell(
          child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8),
            child: Text('operação',
                style: TextStyle(
                    color: Colors.white,
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
                    color: Colors.white,
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
                    color: Colors.white,
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
                    color: Colors.white,
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
                    color: Colors.white,
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
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
          ),
        ),
      ],
    ),
  ]);
}
