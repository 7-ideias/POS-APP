import 'package:flutter/material.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';

import '../controller/produto-controller.dart';

class EscolhaOProduto extends StatefulWidget {
  EscolhaOProduto({Key? key}) : super(key: key);

  @override
  State<EscolhaOProduto> createState() => _EscolhaOProdutoState();
}

class _EscolhaOProdutoState extends State<EscolhaOProduto> {

  bool carregando=true;

  @override
  void initState() {
    atualizarProdutos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('escolha o produto')),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () async {
        await atualizarProdutos();
      },),
      body: RefreshIndicator(
        onRefresh: () async => await atualizarProdutos(),
        child:
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: VariaveisGlobais.produtoList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (){
                var produtoDto = VariaveisGlobais.produtoList[index];
                Navigator.pop(context,produtoDto);
              },
              child: ListTile(
                leading: const CircleAvatar(
                  maxRadius: 30,
                  child: Icon(Icons.question_mark),
                ),
                title: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('${VariaveisGlobais.produtoList[index].codigoDeBarras}'),
                    Text('${VariaveisGlobais.produtoList[index].nomeProduto}'),
                  ],
                ),
              ),
            );
          },
        ) ,
      ),
    );
  }

  Future<void> atualizarProdutos()async {
    setState(() {
      carregando = true;
    });
    await ProdutoController().atualizarListaDeProdutos();
    setState(() {
      carregando = false;
    });
  }

}
