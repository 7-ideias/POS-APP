import 'package:flutter/material.dart';
import 'package:pos_app/controller/produto_controller.dart';
import 'package:pos_app/screens/produto_detalhe_tela.dart';

import '../dtos/produto_dto.dart';
import '../utilitarios/utils.dart';

class ProdutosTela extends StatefulWidget {
  @override
  _ProdutosTelaState2 createState() => _ProdutosTelaState2();
}

class _ProdutosTelaState2 extends State<ProdutosTela> {
  List<Produto> produtoList = [];
  bool isLoading = true;
  late String idProduto;
  late ResponseModel resumo;

  @override
  void initState() {
    super.initState();
    getProdutoList();
  }

  @override
  Widget build(BuildContext context) {

    var _termoDaBusca = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.indigoAccent,
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('itens no estoque.: ',style: TextStyle(fontSize: 22, color: Colors.white),),
                      isLoading == false ? Text(resumo.qtNoEstoque.toString(),style: TextStyle(fontSize: 22, color: Colors.white),) : Container()
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('valor do estoque.: R\$ ',style: TextStyle(fontSize: 22, color: Colors.white),),
                      isLoading == false ? Text(resumo.vlEstoqueEmGrana.toString(),style: TextStyle(fontSize: 22, color: Colors.white),) : Container()
                    ],
                  ),
                )
              ],
            ),
          ),
          Card(
            elevation:10,
            child: TextField(
              controller: _termoDaBusca,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'digite para buscar',
              ),
              // controller: searchController,
              onChanged: (value) {
                // Lógica para filtrar a lista de produtos com base no texto digitado
              },
            ),
          ),
          Utils.getEspacamento(),
          Utils.getEspacamento(),
          Utils.getEspacamento(),
          Expanded(
            child: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: produtoList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          // leading: Icon(Icons.add_a_photo),
                          title: Text(produtoList[index].nomeProduto),
                          subtitle: Row(
                            children: [
                              Text("estoque atual.: "+produtoList[index].objCalculosDeProdutoDoBackEnd.qtNoEstoque.toString()),
                              Text(" - "),
                              Text("preço.: R\$  "+produtoList[index].precoVenda.toString()),
                            ],
                          ),
                          shape: Border.all(color: Colors.black12),
                          trailing: Icon(Icons.arrow_forward),
                          onTap: () {
                            idProduto = produtoList[index].id;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProdutoDetalheTela(idProduto: idProduto,),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getProdutoList();
        },
        child: Icon(Icons.refresh),
      ),
    );
  }

  void getProdutoList() {
    setState(() {
      isLoading = true;
    });
     var buscarProdutoList = ProdutoController().buscarProdutoList();
    buscarProdutoList.then((listaProdutos) {
      produtoList = listaProdutos.produtosList;
      setState(() {
       resumo = listaProdutos;
        isLoading = false;
      });
    }).catchError((erro) {
      print(erro);
      // Trate qualquer erro que ocorra durante a obtenção dos produtos
    });
  }
}
