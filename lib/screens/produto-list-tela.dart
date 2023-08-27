import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pos_app/controller/produto-controller.dart';
import 'package:pos_app/screens/produto-adicionar-diminuir-estoque-rapido.dart';
import 'package:pos_app/screens/produto-novo-edicao-tela.dart';
import 'package:pos_app/utilitarios/utils.dart';
import '../dtos/produto-dto-list.dart';
import '../dtos/produto-dto.dart';
import 'package:http/http.dart' as http;

import '../utilitarios/VariaveisGlobais.dart';

class ProdutosTela extends StatefulWidget {
  @override
  _ProdutosTelaState2 createState() => _ProdutosTelaState2();
}

class _ProdutosTelaState2 extends State<ProdutosTela> {

  double tamanhoDaFonte = 20;

  bool isLoading = true;
  bool _temConteudo = false;
  late String idProduto;
  List<ProdutoDto> produtoList = [];
  late ProdutoDtoList produtoDtoList;
  bool mostrarTudo = false;

  @override
  void initState() {
    super.initState();
    getProdutoList();
  }

  @override
  Widget build(BuildContext context) {

    int _selectedIndex = 0;


    Future<void> _onItemTapped(int index) async {
      if(index == 1){
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProdutoNovoEdicaoTela(
              idProduto: VariaveisGlobais.NOVO_PRODUTO,
            ),
          ),
        );
        getProdutoList();
      }
    }

    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Center(child: Text('Produtos')),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'nada aqui',
          ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add,size: 30,),
              label: 'novo produto',
            ),
        ],
      ),
      body: Column(
        children: [
          Card(
            elevation: 10,
            child: Container(
              height: MediaQuery.of(context).size.height * .15,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: cartaoDeProdutos(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'digite para buscar',
                  suffixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  setState(() {
                    var listagem = produtoDtoList.produtosList;
                    produtoList = listagem
                        .where((produto) => produto.nomeProduto
                            .toLowerCase()
                            .contains(value.toLowerCase()) || produto.codigoDeBarras
                        .toLowerCase()
                        .contains(value.toLowerCase()))
                        .toList();
                  });
                },
              ),
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: () => getProdutoList(),
                    child: _temConteudo == true ?
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: produtoList.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                            startActionPane: esquerdaDireitaPane(index),
                            endActionPane: direitaEsquertaPane(index),
                            child:Container(
                              child: ListTile(
                                isThreeLine: true,
                                leading: const CircleAvatar(
                                  maxRadius: 30,
                                  child: Icon(Icons.question_mark),
                                ),
                                title: Text(produtoList[index].nomeProduto,style: TextStyle(fontSize: 20)),

                                subtitle: Column(
                                  children: [
                                    Row(children: [Text('código.: '+produtoList[index].codigoDeBarras)],),
                                    Row(
                                      children: [
                                        Text("estoque atual.: ${produtoList[index]
                                                .objCalculosDeProdutoDoBackEnd
                                                .qtNoEstoque}",style: TextStyle(fontSize: 13)),
                                        Text(" - preço.: ${Utils.formataParaMoeda(produtoList[index].precoVenda)}",
                                            style: TextStyle(fontSize: 13)),
                                      ],
                                    ),

                                  ],
                                ),
                                // tileColor: produtoList[index]
                                //     .objCalculosDeProdutoDoBackEnd
                                //     .qtNoEstoque < 10
                                //     ? Colors.red
                                //     : null,
                              ),
                            ),
                        );
                      },
                    ) : Container(),
                  ),
          ),
        ],
      ),

      // floatingActionButton: Column(
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   crossAxisAlignment: CrossAxisAlignment.end,
      //   children: [
      //     SizedBox(
      //       height: 10,
      //     ),
      //     mostrarTudo == true ?FloatingActionButton.extended(
      //       backgroundColor: Colors.green,
      //       onPressed: () {
      //         Navigator.push(
      //           context,
      //           MaterialPageRoute(
      //             builder: (context) => ProdutoNovoEdicaoTela(
      //               idProduto: VariaveisGlobais.NOVO_PRODUTO,
      //             ),
      //           ),
      //         );
      //       },
      //       label: Row(
      //         children: [
      //           Icon(Icons.add),
      //           Text('  adicionar novo produto',style: TextStyle(fontSize: tamanhoDaFonte),),
      //         ],
      //       ),
      //     ):Container(),
      //     SizedBox(
      //       height: 10,
      //     ),
      //     FloatingActionButton.extended(
      //       onPressed: () {
      //         setState(() {
      //           mostrarTudo = !mostrarTudo;
      //         });
      //       },
      //       label: mostrarTudo == false ? Row(
      //         children: [
      //           Icon(Icons.add),
      //           Text(' mais ações', style: TextStyle(fontSize: tamanhoDaFonte)),
      //         ],
      //       ) : Row(
      //         children: [
      //           Icon(Icons.hide_source),
      //           Text(' esconder ações', style: TextStyle(fontSize: tamanhoDaFonte)),
      //         ],
      //       ),
      //     ),
      //     SizedBox(
      //       height: 10,
      //     ),
      //     FloatingActionButton(onPressed: getProdutoList,child: Icon(Icons.refresh),)
      //   ],
      // ),

    );
  }

  Widget cartaoDeProdutos() {
    return Column(
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.remove_red_eye,size: 30),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'itens no estoque.: ',
                        style: TextStyle(fontSize: tamanhoDaFonte ),
                      ),
                      isLoading == false
                          ? Text(
                        _temConteudo == true ? produtoDtoList.qtNoEstoque.toString() : '0',
                              style:
                                  TextStyle(fontSize: tamanhoDaFonte ),
                            )
                          : Container()
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      isLoading == false
                          ? Text(
                        _temConteudo == true ? 'vl estoque.: '+ Utils.formataParaMoeda(produtoDtoList.vlEstoqueEmGrana) : '0',
                              style:
                                  TextStyle(fontSize: tamanhoDaFonte),
                            )
                          : Container()
                    ],
                  ),
                ],
              )
            ],
          );
  }

  ActionPane esquerdaDireitaPane(int index) {
    return ActionPane(
      motion: const StretchMotion(),
      children: [
        SlidableAction(
          backgroundColor: Colors.red,
          icon: Icons.clear,
          onPressed:  (context) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Confirmação'),
                    content: Text('quer realmente apagar?'),
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
                          excluirProdutoPorID(produtoList[index].id);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
          },
        ),

      ],

    );
  }

  ActionPane direitaEsquertaPane(int index) {
    return ActionPane(
      motion: const StretchMotion(),
      children: [
        SlidableAction(
          backgroundColor: Colors.red,
          icon: Icons.arrow_downward_outlined,
          onPressed:  (context) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProdutoEstoqueRapidoTela(
                  produtoList: [produtoList[index]], adicionarOuBaixar: 'baixar',)),
            );
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ProdutoNovoEdicaoTela(
            //       idProduto: idProduto,
            //     ),
            //   ),
            // );
          },
        ),
        SlidableAction(
          backgroundColor: Colors.green,
          icon: Icons.arrow_upward_rounded,
          onPressed:  (context) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProdutoEstoqueRapidoTela(
                  produtoList: [produtoList[index]], adicionarOuBaixar: 'adicionar')),
            );
            // idProduto = produtoList[index].id;
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ProdutoNovoEdicaoTela(
            //       idProduto: idProduto,
            //     ),
            //   ),
            // );
          },
        ),
        SlidableAction(
          backgroundColor: Colors.blueAccent,
          icon: Icons.remove_red_eye_outlined,
          onPressed:  (context) {
            idProduto = produtoList[index].id;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdutoNovoEdicaoTela(
                  idProduto: idProduto,
                ),
              ),
            );
          },
        ),

      ],

    );
  }

  Future<void> excluirProdutoPorID (String id) async {

    setState(() {
      isLoading = true;
    });

    var url = '${VariaveisGlobais.endPoint}/produto/apagar/' + id;
    String idDeQuemEstaCadastrando = '${VariaveisGlobais.usuarioDto.id}';
    var headers = {
      'Content-Type': 'application/json',
      'idUsuario': '${VariaveisGlobais.usuarioDto.id}',
      'idColaborador': idDeQuemEstaCadastrando
    };
    var response = await http.delete(Uri.parse(url), headers: headers);

    await getProdutoList();

  }


  Future<void> getProdutoList() async {
    setState(() {
      isLoading = true;
      _temConteudo = false;
    });
    http.Response fazRequisicao = await ProdutoController().fazRequisicao();
    if (fazRequisicao.statusCode == 200){
      var buscarProdutoList = ProdutoController().buscarProdutoList(fazRequisicao);
      buscarProdutoList.then((listaProdutos) {
        produtoList = listaProdutos.produtosList;
        setState(() {
          produtoDtoList = listaProdutos;
          isLoading = false;
          mostrarTudo = false;
          _temConteudo = true;
        });
      }).catchError((erro) {
        print(erro);
      });
    }else{
      setState(() {
        isLoading = false;
      });
    }
  }
}
