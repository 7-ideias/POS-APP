import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pos_app/controller/produto-controller.dart';
import 'package:pos_app/dtos/operacao-dto.dart';
import 'package:pos_app/screens/produto-adicionar-diminuir-estoque-rapido.dart';
import 'package:pos_app/screens/produto-novo-edicao-tela.dart';

import '../controller/app_controller.dart';
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
    return Scaffold(
      backgroundColor: AppController.instance.corTelaFundo,
      appBar: AppBar(
        title: Text('Produtos'),
      ),
      body: Column(
        children: [
          Container(
            color: AppController.instance.corTelaAcima,
            height: 150,
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'itens no estoque.: ',
                        style: TextStyle(fontSize: tamanhoDaFonte, color: Colors.white),
                      ),
                      isLoading == false
                          ? Text(
                        _temConteudo == true ? produtoDtoList.qtNoEstoque.toString() : '0',
                              style:
                                  TextStyle(fontSize: tamanhoDaFonte, color: Colors.white),
                            )
                          : Container()
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      isLoading == false
                          ? Text(
                        _temConteudo == true ? 'vl estoque.: '+VariaveisGlobais.moeda + produtoDtoList.vlEstoqueEmGrana.toString() : '0',
                              style:
                                  TextStyle(fontSize: tamanhoDaFonte, color: AppController.instance.corLetras),
                            )
                          : Container()
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.white,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'digite para buscar',
                  suffixIcon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  print(value);
                  setState(() {
                    var listagem = produtoDtoList.produtosList;
                    produtoList = listagem
                        .where((produto) => produto.nomeProduto
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
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Slidable(
                              endActionPane: direitaEsquertaPane(index),
                              child:Container(
                                color: AppController.instance.corTelaAcima,
                                child: ListTile(
                                  leading: CircleAvatar(
                                    maxRadius: 30,
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.question_mark),
                                  ),
                                  title: Text(produtoList[index].nomeProduto,style: TextStyle(color: AppController.instance.corLetras,fontSize: 20)),
                                  subtitle: Row(
                                    children: [
                                      Text("estoque atual.: " +
                                          produtoList[index]
                                              .objCalculosDeProdutoDoBackEnd
                                              .qtNoEstoque
                                              .toString(),style: TextStyle(color: AppController.instance.corLetras,fontSize: 13)),
                                      Text(" - preço.: " +VariaveisGlobais.moeda+
                                          produtoList[index].precoVenda.toString(),style: TextStyle(color: AppController.instance.corLetras,fontSize: 13)),
                                    ],
                                  ),
                                  // tileColor: produtoList[index]
                                  //     .objCalculosDeProdutoDoBackEnd
                                  //     .qtNoEstoque < 10
                                  //     ? Colors.red
                                  //     : null,
                                  shape: Border.all(color: AppController.instance.corLetras),
                                ),
                              ),
                          ),
                        );
                      },
                    ) : Container(),
                  ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 10,
          ),
          mostrarTudo == true ?FloatingActionButton.extended(
            backgroundColor: Colors.green,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProdutoNovoEdicaoTela(
                    idProduto: VariaveisGlobais.NOVO_PRODUTO,
                  ),
                ),
              );
            },
            label: Row(
              children: [
                Icon(Icons.add),
                Text('  adicionar novo produto',style: TextStyle(fontSize: tamanhoDaFonte),),
              ],
            ),
          ):Container(),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                mostrarTudo = !mostrarTudo;
              });
            },
            label: mostrarTudo == false ? Row(
              children: [
                Icon(Icons.add),
                Text(' mais ações', style: TextStyle(fontSize: tamanhoDaFonte)),
              ],
            ) : Row(
              children: [
                Icon(Icons.hide_source),
                Text(' esconder ações', style: TextStyle(fontSize: tamanhoDaFonte)),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(onPressed: getProdutoList,child: Icon(Icons.refresh),)
        ],
      ),
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
