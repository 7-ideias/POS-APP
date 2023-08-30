import 'package:flutter/material.dart';
import 'package:pos_app/controller/app_controller.dart';

import '../controller/operacao-controller.dart';
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

  String numeroDeVendas = '0';

  bool mostrarOpcoes = false;

  double espacoEntreOsFloatings = 20.0;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    atualizarParametrosDaTela();
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
      backgroundColor: AppController.instance.buildThemeData().primaryColorDark,
      appBar: buildAppBar(context),
      drawer: MenuLateral(context),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          mostrarOpcoes == true ? FloatingActionButton.extended(
            backgroundColor: Colors.green,
            onPressed: () async {

            },
            label: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.add),
                Text('nova venda/serviço' ),
              ],
            ),
          ):Container(),
          SizedBox(height: espacoEntreOsFloatings),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                child: Icon(mostrarOpcoes == true ? Icons.minimize_outlined: Icons.add),
                onPressed: () {
                   setState(() {
                     mostrarOpcoes = !mostrarOpcoes;
                   });
                },
              ),
            ],
          ),
          SizedBox(height: espacoEntreOsFloatings),
          if(mostrarOpcoes==false)Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                child: const Icon(Icons.refresh),
                onPressed: () {
                    atualizarParametrosDaTela();
                },
              ),
            ],
          ),
        ],
      ),
      body:
      AnimatedOpacity(
        opacity: mostrarOpcoes == true ? 0.1 : 1,
        duration: Duration(seconds: 1),
          child: Stack(
            children: [
              ListView(children: [
                Stack(
                  children: [
                    Container(
                      key: keyContainer,
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
                                  const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 20),
                                      Text('Ola',
                                          style: TextStyle(
                                              fontSize: 18)),
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
                            // color: AppController.instance.corTelaAcima,
                            elevation: 10,
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                              width: MediaQuery.of(context).size.width * 0.95,
                              //icones laterais no card
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 30,
                                    left: 30,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text('operacoes do dia R\$ 1000,88',style: TextStyle(fontSize: 18),),
                                        Text('vendas - '+ numeroDeVendas,style: TextStyle(fontSize: 18),),
                                        Text('servicos - 3',style: TextStyle(fontSize: 18),),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: GestureDetector(
                                              onTap: () {

                                              },
                                              child: Icon(
                                                  size: 30,
                                                  Icons.remove_red_eye),
                                            ),
                                          )
                                        ],
                                      ),
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
                                              child: Icon(
                                                      size: 30,
                                                      Icons.shopping_cart),
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child:  Icon(
                                                    size: 30,
                                                    Icons.monetization_on),
                                          )
                                        ],
                                      ),
                                    ],
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
                SizedBox(height: espacoEntreOsFloatings * 2),
                if(_isExpanded == false) Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('DIA',
                                  style: TextStyle(
                                    fontSize: 22,
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
                if(_isExpanded == false) Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('MÊS',
                                  style: TextStyle(
                                    fontSize: 18,
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
                if(_isExpanded == false) Card(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('resumo do dia',
                                  style: TextStyle(
                                    fontSize: 18,
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
              ],
              ),
              if(mostrarOpcoes == true)Container(
                color: Colors.transparent,
              ),
            ],
          ),
        ),
    );
  }

  Future<void> atualizarParametrosDaTela() async {
    await OperacaoController().atualizarOperacoes();
    setState(() {
      numeroDeVendas =   VariaveisGlobais.operacoesBackEnd.quantidadeDeOps.toString();
    });
  }

}

Table ResumoTable() {
  return Table(
      border: TableBorder.all(
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
                        fontWeight: FontWeight.bold,
                        fontSize: 18)),
              ),
            ),
          ],
        ),
      ]);
}
