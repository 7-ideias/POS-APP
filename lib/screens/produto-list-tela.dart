import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/controller/produto-controller.dart';
import 'package:pos_app/screens/produto-adicionar-diminuir-estoque-rapido.dart';
import 'package:pos_app/screens/produto-novo-edicao-tela.dart';
import 'package:pos_app/utilitarios/utils.dart';

import '../controller/app_controller.dart';
import '../dtos/produto-dto-list.dart';
import '../dtos/produto-dto.dart';
import '../utilitarios/VariaveisGlobais.dart';

class ProdutosTela extends StatefulWidget {
  final String produtoOuServico;
  ProdutosTela(this.produtoOuServico, {Key? key}) : super(key: key);

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
  bool _revelarValores = false;
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getProdutoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Center(child: Text(widget.produtoOuServico)),
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.report),
      //       label: 'nada aqui',
      //     ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.add,size: 30,),
      //         label: 'novo produto',
      //       ),
      //   ],
      // ),
      body:  SafeArea(
        child: AnimatedOpacity(
          opacity: mostrarTudo == true ? 0.2 : 1,
          duration: Duration(seconds: 1),
          child: Stack(
            children: [
              Column(
                children: [
                  _revelarValores == true ? Card(
                    elevation: 10,
                    child: Container(
                      height: MediaQuery.of(context).size.height * .2,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: cartaoDeProdutos(),
                      ),
                    ),
                  ):Card(
                    elevation: 10,
                    child: Container(
                      height: MediaQuery.of(context).size.height * .05,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              _revelarValores = !_revelarValores;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.remove_red_eye,size: 30),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Buscar um produto',
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: _searchController.text.length > 0 ? GestureDetector(
                            onTap: () {
                              setState(() {
                                _searchController.clear(); // Limpa o campo de busca
                                produtoList = produtoDtoList.produtosList; // Restaura a lista original
                              });
                            },
                            child: Icon(Icons.clear),
                          ):null,
                        ),
                        onChanged: (value) {
                          setState(() {
                            produtoList = produtoDtoList.produtosList
                                .where((produto) =>
                            produto.nomeProduto
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                                produto.codigoDeBarras
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
                        ? const Center(
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
                                    child:ListTile(
                                      tileColor: produtoList[index].ativo==false?CupertinoColors.inactiveGray:null,
                                      isThreeLine: true,
                                      //TODO aqui tem que arrumar um jeito de colocar um container pra inserir a foto e ficar mais bacana
                                      leading: CircleAvatar(
                                        maxRadius: 80,
                                       child: Icon(Icons.question_mark),
                                      ),
                                      title: Text(produtoList[index].nomeProduto,style: TextStyle(fontSize: 20)),
                                      subtitle: Column(
                                        children: [
                                          Row(children: [Text('código: '+produtoList[index].codigoDeBarras,style: TextStyle(fontSize: 16))],),
                                          Row(
                                            children: [
                                              Text("${Utils.formataParaMoeda(produtoList[index].precoVenda)}",
                                                  style: TextStyle(fontSize: 20,
                                                    color: Colors.orange.shade900,
                                                    fontWeight: FontWeight.w600
                                                  ),),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text("Estoque: ${produtoList[index]
                                                      .objCalculosDeProdutoDoBackEnd
                                                      .qtNoEstoque}",style: TextStyle(fontSize: 16)),
                                              if(produtoList[index].objCalculosDeProdutoDoBackEnd.qtNoEstoque < produtoList[index].estoqueMinimo)
                                                Tooltip(
                                                  message: "Estoque baixo!",
                                                  child: Icon(Icons.arrow_downward_rounded,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              if(produtoList[index]
                                                  .objCalculosDeProdutoDoBackEnd
                                                  .qtNoEstoque > produtoList[index].estoqueMaximo)
                                                Tooltip(
                                                  message: "Estoque alto!",
                                                  child: Icon(Icons.arrow_upward_rounded,
                                                  color: Colors.deepOrange,
                                                  ),
                                                ),
                                              if(produtoList[index].objCalculosDeProdutoDoBackEnd.qtNoEstoque >= produtoList[index].estoqueMinimo &&
                                                  produtoList[index].objCalculosDeProdutoDoBackEnd.qtNoEstoque <= produtoList[index].estoqueMaximo)
                                                Tooltip(
                                                  message: "Estoque dentro do esperado",
                                                  child: Icon(Icons.check,
                                                  color: Colors.green,
                                                  ),
                                                ),
                                              if(produtoList[index].ativo==false)
                                                Tooltip(
                                                  message: "Bloqueado para venda",
                                                  child: Icon(Icons.error_outline,
                                                  color: Colors.red,),
                                                ),
                                            ],
                                          ),
                                          SizedBox(height: 10,),
                                        ],
                                      ),
                                    ),
                                );
                              },
                            ) : Container(),
                          ),
                  ),
                ],
              ),
              if(mostrarTudo == true)GestureDetector(
                onTap: (){
                  setState(() {
                    mostrarTudo = !mostrarTudo;
                  });
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 10,
          ),
          if(widget.produtoOuServico=='PRODUTO') if(mostrarTudo == true) FloatingActionButton.extended(
            backgroundColor: Colors.green,
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
              getProdutoList();
            },
            label: Row(
              children: [
                Icon(Icons.add),
                Text('  adicionar novo produto',),
              ],
            ),
          ) ,
          if(widget.produtoOuServico=='SERVICO') if(mostrarTudo == true) FloatingActionButton.extended(
            backgroundColor: Colors.green,
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProdutoNovoEdicaoTela(
                    idProduto: 'XXXXX',
                    novoOuEdicao: 'NOVO',
                    produtoOuServico: 'SERVICO',
                  ),
                ),
              );
              getProdutoList();
            },
            label: Row(
              children: [
                Icon(Icons.add),
                Text('  adicionar novo servico',),
              ],
            ),
          ) ,
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
                Text(' mais ações',),
              ],
            ) : Row(
              children: [
                Text('X'),
                Text(' fechar'),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          if(mostrarTudo==false)FloatingActionButton(onPressed: getProdutoList,child: Icon(Icons.refresh),)
        ],
      ),
    );
  }

  Widget cartaoDeProdutos() {
    return Column(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        _revelarValores = !_revelarValores;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.remove_red_eye,size: 30),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              Column(
                children: [
                  if(_revelarValores == true)Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: AppController.instance.buildThemeData().focusColor,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'quantidade de produtos cadastrados.: ',
                        ),
                        isLoading == false
                            ? Text(
                          _temConteudo == true ? produtoDtoList.produtosList.length.toString() : '0',)
                            : Container()
                      ],
                    ),
                  ),
                  if(_revelarValores == true)Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: AppController.instance.buildThemeData().focusColor,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'itens no estoque.: ',
                        ),
                        isLoading == false
                            ? Text(
                          _temConteudo == true ? produtoDtoList.qtNoEstoque.toString() : '0',
                              )
                            : Container()
                      ],
                    ),
                  ),
                  if(_revelarValores == true)Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                        color: AppController.instance.buildThemeData().focusColor,
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        isLoading == false
                            ? Text(
                          _temConteudo == true ? 'valor do patrimônio.: '+ Utils.formataParaMoeda(produtoDtoList.vlEstoqueEmGrana) : '0')
                            : Container()
                      ],
                    ),
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
          label: 'apagar produto',
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
          onPressed:  (context)async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProdutoEstoqueRapidoTela(
                  produtoList: [produtoList[index]], adicionarOuBaixar: 'baixar',)),
            );
            getProdutoList();
          },
        ),
        SlidableAction(
          backgroundColor: Colors.green,
          icon: Icons.arrow_upward_rounded,
          onPressed:  (context) async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProdutoEstoqueRapidoTela(
                  produtoList: [produtoList[index]], adicionarOuBaixar: 'adicionar')),
            );
            getProdutoList();
          },
        ),
        SlidableAction(
          backgroundColor: Colors.blueAccent,
          icon: Icons.remove_red_eye_outlined,
          onPressed:  (context) async { 
            idProduto = produtoList[index].id;
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProdutoNovoEdicaoTela(
                  idProduto: idProduto,
                  novoOuEdicao: 'EDITAR',
                  produtoOuServico: widget.produtoOuServico,
                ),
              ),
            );
            getProdutoList();
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
    String idDeQuemEstaCadastrando = '${VariaveisGlobais.usuarioDto.idUsuario}';
    var headers = {
      'Content-Type': 'application/json',
      'idUsuario': '${VariaveisGlobais.usuarioDto.id}',
      'idColaborador': idDeQuemEstaCadastrando
    };
    var response = await http.delete(Uri.parse(url), headers: headers);
    if (response.statusCode == 409){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        duration: Duration(seconds: 5),
        backgroundColor: Colors.red,
        content: Text("não é possível apagar pois existem vendas para esse produto"),
      ));
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        elevation: 10,
        duration: Duration(seconds: 2),
        backgroundColor: Colors.green,
        content: Text("apaguei com sucesso"),
      ));
    }
      await getProdutoList();

  }

  Future<void> getProdutoList() async {
    setState(() {
      isLoading = true;
      _temConteudo = false;
    });
    http.Response fazRequisicao = await ProdutoController().fazRequisicao(widget.produtoOuServico,false);
    if (fazRequisicao.statusCode == 200){
      var buscarProdutoList = ProdutoController().buscarProdutoList(fazRequisicao,false);
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
