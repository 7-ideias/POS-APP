import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/dtos/objetos/obj-agenda.dart';
import 'package:pos_app/dtos/objetos/obj-calculos-de-operacao-do-back-end.dart';
import 'package:pos_app/utilitarios/utils.dart';

import '../controller/app_controller.dart';
import '../controller/produto-controller.dart';
import '../dtos/objetos/obj-venda-e-servico.dart';
import '../dtos/operacao-dto.dart';
import '../utilitarios/VariaveisGlobais.dart';
import '../utilitarios/tela_inteira.dart';
import 'operacao-inserindo.dart';

class OperacaoNova extends StatefulWidget {
  const OperacaoNova({Key? key}) : super(key: key);
  @override
  State<OperacaoNova> createState() => _OperacaoNovaState();
}

class _OperacaoNovaState extends State<OperacaoNova> {

  List<ObjVendaEServico> objVendaEServicoList = [];
  DateTime dataDaOperacao = DateTime.now();
  double somaValorTotal = 0.00;
  double totalDeItens = 0.00;

  bool _isLoading = false;
  bool confirmacaoDeSucessoNaAPI = false;
  bool mostrarOpcoesDoFloat = false;
  bool exibirContainerTransparente = false;

  bool carregando = true;

  double tamanhoDoCupom = 50;

  @override
  Widget build(BuildContext context) {
    return _isLoading == true ?
    (_isLoading == true && confirmacaoDeSucessoNaAPI == true ? TelaInteira().sucesso():
    TelaInteira().widgetDeLoadingPadraoDoApp()):Scaffold(
      // backgroundColor: AppController.instance.buildThemeData().primaryColor,
      appBar: AppBar(title: Text('nova')),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if(mostrarOpcoesDoFloat==true)Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if(objVendaEServicoList.length > 0)FloatingActionButton.extended(
                backgroundColor: AppController.instance.botaoConfirmar,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirmação'),
                        content: Text('gravar a operação?\nVerifique as informações antes de salvar'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancelar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Confirmar'),
                            onPressed: () async {
                              Navigator.of(context).pop();
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('receber agora?'),
                                    content: Text('quer receber agora?'),
                                    actions: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: TextButton(
                                          child: Text('receber depois'),
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                            await sendApiNovaOperacao();
                                          },
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.only(left: 5,right: 5),
                                        decoration: BoxDecoration(
                                            color: AppController.instance.buildThemeData().focusColor,
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                        child: TextButton(
                                          child: Text('receber agora'),
                                          onPressed: () {
                                            Navigator.of(context).pop();

                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ) ;
                },
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.save),
                    Text(' salvar' ),
                  ],
                ),
              ) ,
              SizedBox(width: 20,),
              if(objVendaEServicoList.length > 0)FloatingActionButton.extended(
                backgroundColor: AppController.instance.botaoNegar,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirmação'),
                        content: Text('abandonar a operação?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancelar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Confirmar'),
                            onPressed: () async {
                              Navigator.pushNamedAndRemoveUntil(context, "/home", (Route<dynamic> route) => false);
                            },
                          ),
                        ],
                      );
                    },
                  ) ;

                },
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.cancel),
                    Text(' cancelar' ),
                  ],
                ),
              ) ,
            ],
          ),
          SizedBox(height: 20,),
          if(mostrarOpcoesDoFloat==true)FloatingActionButton.extended(
            onPressed: () {
              atualizarProdutos('PRODUTO');
              retornaOsDadosDaTelaOperacaoInserindo(context);
            },
            label: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.add),
                Text('adicionar serviços' ),
              ],
            ),
          ),
          if(mostrarOpcoesDoFloat==true)SizedBox(height: 20,),
          //adicionar novo
          if(mostrarOpcoesDoFloat==true)FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                exibirContainerTransparente = false;
              });
              atualizarProdutos('PRODUTO');
              retornaOsDadosDaTelaOperacaoInserindo(context);
            },
            label: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.add),
                Text('adicionar produtos' ),
              ],
            ),
          ),
          if(mostrarOpcoesDoFloat==true)SizedBox(height: 20,),
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                mostrarOpcoesDoFloat = !mostrarOpcoesDoFloat;
                exibirContainerTransparente = !exibirContainerTransparente;
              });
            },
            label: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(mostrarOpcoesDoFloat==false ? Icons.add : Icons.clear),
                Text(mostrarOpcoesDoFloat==false ? 'mostrar opções' : 'reduzir'),
              ],
            ),
          )
        ],
      ),
      body: AnimatedOpacity(
    opacity: exibirContainerTransparente == true ? 0.2 : 1,
    duration: Duration(seconds: 1),
    child:Stack(
      children: [
        objVendaEServicoList.length > 0 ?
          comOperacaoEmAndamento(context):AindaSemNadaNaOperacao(),
        if(exibirContainerTransparente == true)GestureDetector(
          onTap: (){
            setState(() {
              mostrarOpcoesDoFloat = false;
              exibirContainerTransparente = false;
            });
          },
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ],
    )),

    );
  }

  Widget comOperacaoEmAndamento(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Card(
            elevation: 10,
            child: Container(
              color: AppController.instance.buildThemeData().cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              elevation: 10,
                              duration: Duration(seconds: 5),
                              backgroundColor: Colors.red,
                              content: Text("deve chamar a lista de ciente"),
                            ));
                        },
                          child: Row(
                            children: [
                              Icon(Icons.person),
                              SizedBox(width: 10,),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: AppController.instance.buildThemeData().focusColor,
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: Text(' cliente nao informado', ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white
                                  ),
                                  height: 200,
                                  child: CupertinoDatePicker(
                                    mode: CupertinoDatePickerMode.date,
                                    onDateTimeChanged: (DateTime newDate) {
                                      setState(() {
                                        dataDaOperacao = newDate;
                                      });
                                    },
                                  ),
                                );
                              },
                            );

                            // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            //   elevation: 10,
                            //   duration: Duration(seconds: 5),
                            //   backgroundColor: Colors.red,
                            //   content: Text("alterar a data"),
                            // ));
                          },
                          child: Row(
                            children: [
                              Icon(Icons.date_range),
                              SizedBox(width: 10,),
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: AppController.instance.buildThemeData().focusColor,
                                    borderRadius: BorderRadius.circular(5)
                                ),
                                child: Text(Utils.exibicaoDeData(dataDaOperacao),
                                  style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppController.instance.buildThemeData().focusColor,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Row(
                            children: [
                              Text('ITENS.: '),
                              Text(
                                '$totalDeItens',
                                style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppController.instance.buildThemeData().focusColor,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          child: Row(
                            children: [
                              Text('TOTAL.: '),
                              Text(
                                Utils.formataParaMoeda(somaValorTotal),
                                style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
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
          Expanded(
            child: ListView.builder(
              itemCount: objVendaEServicoList.length,
              itemBuilder: (context, index) {
                return Slidable(
                  startActionPane: direitaEsquertaPane(index),
                  child: Card(
                    elevation: 10,
                    child: ListTile(
                      title: Text(
                        objVendaEServicoList[index]
                            .descricaoProduto
                            .toString(),
                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('quantidade.: '),
                              Text(objVendaEServicoList[index].qt.toString(),
                                  style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Container(
                              decoration: BoxDecoration(
                                  color: AppController.instance.buildThemeData().focusColor,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text('un.: '),
                                      Text(Utils.formataParaMoeda(objVendaEServicoList[index].vlUnitario),
                                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text('valor total.: '),
                                      Text(Utils.formataParaMoeda(objVendaEServicoList[index].vlTotal),
                                          style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Container(
          //   padding: EdgeInsets.only(left: 5, right: 5,top: 30),
          //   color: Colors.yellowAccent.shade100,
          //   height: tamanhoDoCupom,
          //   width: MediaQuery.of(context).size.width * .95,
          //   child: Stack(
          //     children: [
          //       Column(
          //         children: [
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Text('TICKET - OPERACAO'),
          //             ],
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             children: [
          //               Text('NOME FANTASIA'),
          //             ],
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             children: [
          //               Text('ENDERECO'),
          //             ],
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.start,
          //             children: [
          //               Text('SAO PAULO - SP'),
          //             ],
          //           ),
          //           Row(
          //             mainAxisAlignment: MainAxisAlignment.center,
          //             children: [
          //               Text(
          //                   '------------------------------------------------------------------------------------'),
          //             ],
          //           ),
          //           Table(
          //             columnWidths: {
          //               0: FlexColumnWidth(20),
          //               1: FlexColumnWidth(30),
          //               2: FlexColumnWidth(10),
          //               3: FlexColumnWidth(20),
          //             },
          //             children: [
          //               TableRow(children: [
          //                 Text('CODIGO', textAlign: TextAlign.center),
          //                 Text('DESCRICAO', textAlign: TextAlign.center),
          //                 Text('QT', textAlign: TextAlign.center),
          //                 Text('VALOR', textAlign: TextAlign.center),
          //               ])
          //             ],
          //           ),
          //           Expanded(
          //             child: ListView.builder(
          //               itemCount: objVendaEServicoList.length,
          //               itemBuilder: (context, index) {
          //                 return Slidable(
          //                     endActionPane: direitaEsquertaPane(index),
          //                     child: Column(
          //                       children: [
          //                         Table(
          //                           columnWidths: {
          //                             0: FlexColumnWidth(20),
          //                             1: FlexColumnWidth(30),
          //                             2: FlexColumnWidth(10),
          //                             3: FlexColumnWidth(20),
          //                           },
          //                           children: [
          //                             TableRow(
          //                               children: [
          //                                 Text(objVendaEServicoList[index]
          //                                     .codigoDeBarras
          //                                     .toString()),
          //                                 Text(objVendaEServicoList[index]
          //                                     .descricaoProduto
          //                                     .toString()),
          //                                 Text(
          //                                     objVendaEServicoList[index]
          //                                         .qt
          //                                         .toString(),
          //                                     textAlign: TextAlign.center),
          //                                 Text(
          //                                     Utils.formataParaMoeda(
          //                                         objVendaEServicoList[index]
          //                                             .vlTotal),
          //                                     textAlign: TextAlign.end)
          //                               ],
          //                             ),
          //                           ],
          //                         ),
          //                       ],
          //                     )
          //                     // ListTile(
          //                     //   title: Text(
          //                     //     objVendaEServicoList[index].descricaoProduto.toString(),
          //                     //   ),
          //                     //   subtitle: Text(objVendaEServicoList[index].vlTotal.toString()),
          //                     // ),
          //                     );
          //               },
          //             ),
          //           ),
          //         ],
          //       ),
          //       Positioned(
          //           bottom: 100,
          //           right: 0,
          //           child: Container(
          //               child: Column(
          //                 children: [
          //                   Row(
          //                     children: [
          //                     Text('TOTAL' + Utils.formataParaMoeda(somaValorTotal),textAlign: TextAlign.end,style: TextStyle(fontSize: 30),)
          //                   ],)
          //                 ],
          //               ))),
          //       ClipPath(
          //         clipper: BottomSerratedClipper(),
          //         child: Container(
          //           height: tamanhoDoCupom,
          //           color: AppController.instance.buildThemeData().primaryColor,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget AindaSemNadaNaOperacao() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // ! novo produto
        GestureDetector(
          onTap: (){
            atualizarProdutos('PRODUTO');
            retornaOsDadosDaTelaOperacaoInserindo(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Card(
                elevation: 10,
                child: Container(
                  color: Colors.black,
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text('produto',style : GoogleFonts.bebasNeue(fontSize: 30,color: Colors.white)),
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: (){

          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Card(
                elevation: 10,
                child: Container(
                  color: Colors.black,
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.2,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text('serviço',style : GoogleFonts.bebasNeue(fontSize: 30,color: Colors.white)),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> retornaOsDadosDaTelaOperacaoInserindo(BuildContext context) async {
    ObjVendaEServico objVendaEServico = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InserindoProduto()),
    );
    setState(() {
      objVendaEServicoList.add(objVendaEServico);
      recalculaValoresParaCard();
      var length = objVendaEServicoList.length;
      print('tamanhoDoCupom antes-> '+tamanhoDoCupom.toString());
      tamanhoDoCupom = tamanhoDoCupom + 50;
      print('tamanhoDoCupom depois-> '+tamanhoDoCupom.toString());
    });
  }

  ActionPane direitaEsquertaPane(int index) {
    return ActionPane(
      motion: const StretchMotion(),
      children: [
        SlidableAction(
          backgroundColor: Colors.red,
          icon: Icons.clear,
          onPressed: (context) {
            objVendaEServicoList.removeAt(index);
            setState(() {
              recalculaValoresParaCard();
            });
          },
        ),
      ],
    );
  }

  Future<void> sendApiNovaOperacao() async {
    setState(() {
      _isLoading = true;
    });
    var url = '${VariaveisGlobais.endPoint}/operacao/inserir';

    // double valorCusto = 0.00;
    // valorCusto = widget.produtoList[0].objCalculosDeProdutoDoBackEnd.ultimoVlEmGranaPagoPeloProduto;

    var json = OperacaoDto(
        id: "id",
        idUsuario: "idUsuario",
        codigoProprioDaOperacao: "codigoProprioDaOperacao",
        descricao: "DESCRICAO",
        objCalculosDeOperacaoDoBackEnd: ObjCalculosDeOperacaoDoBackEnd(vlTotal: 10.00,operacaoTotalmenteRecebida: false),
        objInformacoesDoCadastro: null,
        operacaoFinalizadaEProntaParaOCaixa: false,
        statusQuitada: false,
        tipoDeOperacaoEnum: "VENDA",
        objAgenda: ObjAgenda(
            eventoUnico:false,
            tipoDeRecorrencia:"",
            dataDaUltimaOcorrencia:"",
            dataDeVencimentoParaEventoFuturo:""),
        objLogsList: null,
        vendaList: objVendaEServicoList,
        servicoList: null,
        objRecebimentosList: null,
        dataOperacao: dataDaOperacao.toString()
    ).toJson();

    var body = jsonEncode(json);

    var headers = {
      'Content-Type': 'application/json',
      'idUsuario': '${VariaveisGlobais.usuarioDto.id}',
      'idDeQuemEstaCadastrando': '${VariaveisGlobais.idDoTitularOuColaboradorQueEstaAcessando}',
      'tipoTitularOuColaborador' : '${VariaveisGlobais.usuarioDto.tipoTitularOuColaborador}'
    };

    var response = await http.post(Uri.parse(url), headers: headers, body: body);
    // var response = await http.post(Uri.parse(url), headers: headers, body: body);
    debugPrint(response.statusCode.toString());


    if(response.statusCode == 201){
      setState(() {
        confirmacaoDeSucessoNaAPI = true;
      });
    }
      await Future.delayed(Duration(seconds: 2));

    confirmacaoDeSucessoNaAPI = false;

    setState(() {
        _isLoading = true;
    });
    Navigator.of(context).pop();

  }

  void recalculaValoresParaCard() {
    somaValorTotal = 0.00;
    objVendaEServicoList.forEach((element) {
      somaValorTotal = somaValorTotal + double.parse(element.vlTotal.toString());
    });

    //recalcula a quantidade de itens
    totalDeItens = 0.00;
    objVendaEServicoList.forEach((element) {
      totalDeItens = totalDeItens + double.parse(element.qt.toString());
    });
  }

  Future<void> atualizarProdutos(String produtoOuServico)async {
    print('atualizarProdutos');
    // http.Response fazRequisicao = await ProdutoController().fazRequisicao('PRODUTO',true);
    await ProdutoController().atualizarListaDeProdutos(produtoOuServico,true);
    setState(() {
      carregando = false;
      mostrarOpcoesDoFloat = false;
    });
  }


}


class BottomSerratedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    final serrationWidth = 10.0;
    final serrationHeight = 10.0;

    path.moveTo(0, size.height);
    path.lineTo(0, size.height - serrationHeight);

    for (var i = 0; i < size.width / serrationWidth; i++) {
      final startX = i * serrationWidth;
      final isEven = i % 2 == 0;

      path.lineTo(startX, size.height - serrationHeight);

      if (isEven) {
        path.lineTo(startX + serrationWidth / 2, size.height);
      } else {
        path.lineTo(startX + serrationWidth, size.height - serrationHeight);
      }
    }

    path.lineTo(size.width, size.height - serrationHeight);
    path.lineTo(size.width, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}