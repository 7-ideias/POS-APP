import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pos_app/dtos/produto-dto.dart';
import 'package:pos_app/screens/leitor_de_codigos_de_barras.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';
import 'package:pos_app/utilitarios/tela_inteira.dart';

import '../controller/app_controller.dart';
import '../controller/produto-controller.dart';
import '../dtos/objetos/obj-venda-e-servico.dart';
import '../utilitarios/widgetsGlobais.dart';

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
                title: Text("código" + VariaveisGlobais.produtoList[index].codigoDeBarras +" - "
                    + VariaveisGlobais.produtoList[index].nomeProduto,style: TextStyle(fontSize: 20)),
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
