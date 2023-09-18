import 'package:flutter/material.dart';
import 'package:pos_app/dtos/produto-dto.dart';
import 'package:pos_app/screens/produto-novo-edicao-tela.dart';
import 'package:pos_app/screens/servico_novo_tela.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';
import 'package:pos_app/utilitarios/tela_inteira.dart';
import 'package:pos_app/utilitarios/widgetsGlobais.dart';

import '../controller/produto-controller.dart';
import '../utilitarios/utils.dart';

class EscolhaProdutoOuServico extends StatefulWidget {

  final String produtoOuServico;

  EscolhaProdutoOuServico(this.produtoOuServico,{Key? key}) : super(key: key);

  @override
  State<EscolhaProdutoOuServico> createState() => _EscolhaProdutoOuServicoState();
}

class _EscolhaProdutoOuServicoState extends State<EscolhaProdutoOuServico> {

  bool carregando=true;
  bool mostrarOpcoes = false;
  var produtoListDessaClasse;
  TextEditingController _searchController = TextEditingController();


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
          if(widget.produtoOuServico=='SERVICO')FloatingActionButton.extended(
            backgroundColor: Colors.blue,
            onPressed: () async {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ServicoNovoTela(),
                ),
              );
            },
            label: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.add),
                Text('novo serviço avulso'),
              ],
            ),
          ),
          const SizedBox(height: 10,),
          FloatingActionButton(
            backgroundColor: Colors.red,
            child: Icon(Icons.question_mark),
            onPressed: () {

            },),
          if(widget.produtoOuServico=='SERVICO')const SizedBox(height: 10,),
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
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'digite para buscar',
                prefixIcon: Icon(Icons.search),
                suffixIcon: _searchController.text.length > 0 ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _searchController.clear(); // // Limpa o campo de busca
                      produtoListDessaClasse = VariaveisGlobais.produtoList; // Restaura a lista original
                    });
                  },
                  child: Icon(Icons.clear),
                ):null,
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
          Expanded(child: buildRefreshIndicator()),
        ],
      ),
    );
  }

  RefreshIndicator buildRefreshIndicator() {
    return RefreshIndicator(
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
