import 'package:flutter/material.dart';
import 'package:http/src/response.dart';
import 'package:pos_app/controller/produto-controller.dart';
import 'package:pos_app/screens/produto-novo-edicao-tela.dart';

import '../dtos/produto-dto.dart';
import 'package:http/http.dart' as http;

import '../utilitarios/VariaveisGlobais.dart';

class ProdutosTela extends StatefulWidget {
  @override
  _ProdutosTelaState2 createState() => _ProdutosTelaState2();
}

class _ProdutosTelaState2 extends State<ProdutosTela> {

  double tamanhoDaFonte = 16;

  List<Produto> produtoList = [];
  bool isLoading = true;
  bool _temConteudo = false;
  late String idProduto;
  late ResponseModel resumo;
  bool mostrarTudo = false;

  @override
  void initState() {
    super.initState();
    getProdutoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.indigoAccent,
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
                        _temConteudo == true ? resumo.qtNoEstoque.toString() : '0',
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
                      Text(
                        'valor do estoque.: R\$ ',
                        style: TextStyle(fontSize: tamanhoDaFonte, color: Colors.white),
                      ),
                      isLoading == false
                          ? Text(
                        _temConteudo == true ? resumo.vlEstoqueEmGrana.toString() : '0',
                              style:
                                  TextStyle(fontSize: tamanhoDaFonte, color: Colors.white),
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
                    var listagem = resumo.produtosList;
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
                    child: _temConteudo == true ? ListView.builder(
                      itemCount: produtoList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Icon(Icons.add_a_photo),
                            title: Text(produtoList[index].nomeProduto),
                            subtitle: Row(
                              children: [
                                Text("estoque atual.: " +
                                    produtoList[index]
                                        .objCalculosDeProdutoDoBackEnd
                                        .qtNoEstoque
                                        .toString()),
                                Text(" - "),
                                Text("preço.: R\$  " +
                                    produtoList[index].precoVenda.toString()),
                              ],
                            ),
                            //TODO CORRIGIR PARA A COMPARACAO SER COM O ESTOQUE MINIMO
                            tileColor: produtoList[index]
                                        .objCalculosDeProdutoDoBackEnd
                                        .qtNoEstoque <
                                    10
                                ? Colors.red
                                : null,
                            shape: Border.all(color: Colors.black12),
                            trailing: Icon(Icons.arrow_forward),
                            onTap: () {
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
          resumo = listaProdutos;
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
