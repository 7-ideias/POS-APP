import 'package:flutter/material.dart';
import 'package:pos_app/controller/app_controller.dart';
import 'package:pos_app/utilitarios/shake-icon.dart';

import '../../utilitarios/Donut.dart';
import '../../utilitarios/MenuLateral.dart';
import '../../utilitarios/VariaveisGlobais.dart';
import '../../utilitarios/appbar_do_app.dart';

class PrincipalTela extends StatefulWidget {
  @override
  _PrincipalTelaState createState() => _PrincipalTelaState();
}

class _PrincipalTelaState extends State<PrincipalTela>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isExpanded = false;
  final GlobalKey keyContainer = GlobalKey();
  String opcaoSelecionada = 'Vendas';

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
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
      floatingActionButton: const Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // FloatingActionButton(
              //   child: Icon(Icons.refresh),
              //   onPressed: () {},
              // ),
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
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Column(
                      children: [
                        const SizedBox(width: 20),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text('Ola 😊',
                                  style: TextStyle(
                                      color: AppController.instance.corLetras,
                                      fontSize: 15)),
                            ),
                            ShakeIcon(
                                icon: Icon(
                                    color:
                                    AppController.instance.corLetras,
                                    size: 30,
                                    Icons.monetization_on)),
                          ],
                        ),
                        const SizedBox(width: 20),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                VariaveisGlobais
                                        .usuarioDto.objUser?.objPessoa?.nome ??
                                    'Fulaninho',
                                style: TextStyle(
                                  color: AppController.instance.corLetras,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topCenter,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/operacoes');
                                },
                                child: ShakeIcon(
                                    icon: Icon(
                                        color: AppController
                                            .instance.corLetras,
                                        size: 35,
                                        Icons.shopping_cart)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 20),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 80,),
                  Card(
                    color: AppController.instance.corTelaAcima,
                    elevation: 10,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      height: MediaQuery.of(context).size.height * 0.34,
                      width: MediaQuery.of(context).size.width * 0.96,
                      child:  Column(
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      opcaoSelecionada = 'Vendas';
                                    });
                                  },
                                  child: Container(
                                    width:
                                    MediaQuery.of(context).size.width * 0.195,
                                    height: MediaQuery.of(context).size.height *
                                        0.025,
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: opcaoSelecionada == 'Vendas'
                                          ? Colors.indigo
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Text(
                                      'Vendas',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width * 0.195,
                                  height:
                                  MediaQuery.of(context).size.height * 0.025,
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: opcaoSelecionada == 'Custos'
                                        ? Colors.indigo
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        opcaoSelecionada = 'Custos';
                                      });
                                    },
                                    child: const Text('Custos',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width * 0.195,
                                  height:
                                  MediaQuery.of(context).size.height * 0.025,
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: opcaoSelecionada == 'Estoque'
                                        ? Colors.indigo
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        opcaoSelecionada = 'Estoque';
                                      });
                                    },
                                    child: const Text('Estoque',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width * 0.195,
                                  height:
                                  MediaQuery.of(context).size.height * 0.025,
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: opcaoSelecionada == 'Caixa'
                                        ? Colors.indigo
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        opcaoSelecionada = 'Caixa';
                                      });
                                    },
                                    child: const Text('Caixa',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width * 0.3,
                                  height:
                                  MediaQuery.of(context).size.height * 0.025,
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: opcaoSelecionada == 'Pagamentos'
                                        ? Colors.indigo
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        opcaoSelecionada = 'Pagamentos';
                                      });
                                    },
                                    child: const Text('Pagamentos',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width * 0.195,
                                  height:
                                  MediaQuery.of(context).size.height * 0.025,
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: opcaoSelecionada == 'Receber'
                                        ? Colors.indigo
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        opcaoSelecionada = 'Receber';
                                      });
                                    },
                                    child: const Text('Receber',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width * 0.250,
                                  height:
                                  MediaQuery.of(context).size.height * 0.025,
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                    color: opcaoSelecionada == 'Tendências'
                                        ? Colors.indigo
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        opcaoSelecionada = 'Tendências';
                                      });
                                    },
                                    child: const Text('Tendências',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),


                        ],
                      ),
                    ),

                  ),
                ],
              ),
            ),
          ],
        ),

        const SizedBox(height: 10),
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
                padding: const EdgeInsets.all(8),
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
                padding: const EdgeInsets.all(8),
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
                padding: const EdgeInsets.all(8),
                child: Text('vendas',
                    style: TextStyle(
                        color: AppController.instance.corLetras,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
            ),
            TableCell(
              child: Container(
                padding: const EdgeInsets.all(8),
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
                padding: const EdgeInsets.all(8),
                child: Text('orçamentos',
                    style: TextStyle(
                        color: AppController.instance.corLetras,
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
            ),
            TableCell(
              child: Container(
                padding: const EdgeInsets.all(8),
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
