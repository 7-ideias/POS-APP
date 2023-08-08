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
  List<ProdutoDto> produtoList = [];
  bool isLoading = true;
  late ProdutoDto produtoDto;

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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Utils.getEspacamento(),
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
                                Text("estoque atual.: 00120"),
                                // Text(" - "),
                                // Text("preço.: R\$ 1230,52"),
                              ],
                            ),
                            shape: Border.all(color: Colors.black12),
                            trailing: Icon(Icons.arrow_forward),
                            onTap: () {
                              produtoDto = produtoList[index];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProdutoDetalheTela(produtoDto: produtoDto),
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
    Future<List<ProdutoDto>> futureProdutos =
        ProdutoController().buscarProdutoList();
    futureProdutos.then((listaProdutos) {
      produtoList = listaProdutos;
      setState(() {
        isLoading = false;
      });
    }).catchError((erro) {
      // Trate qualquer erro que ocorra durante a obtenção dos produtos
    });
  }
}
