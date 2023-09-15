import 'package:flutter/material.dart';
import 'package:pos_app/dtos/produto-dto.dart';
import 'package:pos_app/screens/produto-novo-edicao-tela.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';
import 'package:pos_app/utilitarios/tela_inteira.dart';
import 'package:pos_app/utilitarios/widgetsGlobais.dart';

import '../controller/produto-controller.dart';
import '../utilitarios/utils.dart';

class EscolhaOProduto extends StatefulWidget {

  final String produtoOuServico;

  EscolhaOProduto(this.produtoOuServico,{Key? key}) : super(key: key);

  @override
  State<EscolhaOProduto> createState() => _EscolhaOProdutoState();
}

class _EscolhaOProdutoState extends State<EscolhaOProduto> {

  bool carregando=true;
  bool mostrarOpcoes = false;
  var produtoListDessaClasse;

  @override
  void initState() {
    atualizarProdutos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('escolha')),
        // automaticallyImplyLeading: false,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
           FloatingActionButton.extended(
            backgroundColor: Colors.blue,
             onPressed: () async {
               await Navigator.push(
                 context,
                 MaterialPageRoute(
                   builder: (context) => ProdutoNovoEdicaoTela(
                     idProduto: 'XXXXX',
                     novoOuEdicao: 'NOVO',
                     produtoOuServico: widget.produtoOuServico,
                   ),
                 ),
               );
               await atualizarProdutos();
             },
            label: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.add),
                Text(widget.produtoOuServico=='PRODUTO'?'novo produto':'novo serviço'),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          FloatingActionButton(
            child: Icon(Icons.refresh),
            onPressed: () async {
            await atualizarProdutos();
          },),
        ],
      ),
      body: carregando == true ? TelaInteira().widgetDeLoadingPadraoDoApp() : Column(
        children: [
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
                    var listagem = VariaveisGlobais.produtoList;
                    produtoListDessaClasse = listagem
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
          RefreshIndicator(
            onRefresh: () async => await atualizarProdutos(),
            child:
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: produtoListDessaClasse.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: (){
                    var produtoDto = produtoListDessaClasse[index];
                    Navigator.pop(context,produtoDto);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: const CircleAvatar(
                        maxRadius: 30,
                        child: Icon(Icons.question_mark),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${produtoListDessaClasse[index].codigoDeBarras}'),
                          Text('${produtoListDessaClasse[index].nomeProduto}'),
                          Text(Utils.formataParaMoeda(produtoListDessaClasse[index].precoVenda)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ) ,
          ),
        ],
      ),
    );
  }

  Future<void> atualizarProdutos()async {
    setState(() {
      carregando = true;
    });
    await ProdutoController().atualizarListaDeProdutos(widget.produtoOuServico.toUpperCase(),false);
    produtoListDessaClasse = VariaveisGlobais.produtoList;
    setState(() {
      carregando = false;
    });
  }

}
