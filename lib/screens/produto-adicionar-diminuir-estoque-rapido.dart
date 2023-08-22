import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/controller/app_controller.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';

import '../dtos/produto-dto.dart';
import '../utilitarios/widgetsGlobais.dart';

class ProdutoEstoqueRapidoTela extends StatefulWidget {
  List<ProdutoDto> produtoList = [];
  String adicionarOuBaixar;

  ProdutoEstoqueRapidoTela({Key? key, required this.produtoList, required this.adicionarOuBaixar})
      : super(key: key);


  @override
  State<ProdutoEstoqueRapidoTela> createState() =>
      _ProdutoEstoqueRapidoTelaState();
}

class _ProdutoEstoqueRapidoTelaState extends State<ProdutoEstoqueRapidoTela> {
  int _contador = 1;

  bool _isLoading = false;

  TextEditingController numeroController = TextEditingController();
  TextEditingController _precoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppController.instance.corTelaFundo,
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.adicionarOuBaixar == 'adicionar' ? 'ADICIONAR' : 'BAIXAR',
                  style: TextStyle(
                      fontSize: 30, color: AppController.instance.corLetras),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'codigo.: ${widget.produtoList[0].codigoDeBarras}',
                  style: TextStyle(
                      fontSize: 20, color: AppController.instance.corLetras),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.produtoList[0].nomeProduto,
                  style: TextStyle(
                      fontSize: 30, color: AppController.instance.corLetras),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'estoque atual.: ${widget.produtoList[0].objCalculosDeProdutoDoBackEnd.qtNoEstoque.toString()}',
                  style: TextStyle(
                      fontSize: 20, color: AppController.instance.corLetras),
                ),
              ),
              widget.adicionarOuBaixar == 'adicionar' ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text( 'ultimo preço.: ${VariaveisGlobais.moeda}${widget.produtoList[0].objCalculosDeProdutoDoBackEnd.ultimoVlEmGranaPagoPeloProduto}',
                      // 'ultimo preço.:   ${widget.produtoList[0].objCalculosDeProdutoDoBackEnd.ultimoVlEmGranaPagoPeloProduto}',
                      style: TextStyle(
                          fontSize: 20, color: AppController.instance.corLetras),
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Informar o novo preço'),
                              content: TextField(
                                controller: _precoController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  labelText: 'Novo preço',
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    // Ação ao pressionar o botão "Cancelar"
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancelar'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                  },
                                  child: Text('Confirmar'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Icon(Icons.edit, color: AppController.instance.corLetras))
                ],
              ) : Container(),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          _contador <= 1 ? _contador : _contador--;
                          print(_contador);
                        });
                      },
                      child: CircleAvatar(
                        maxRadius: 50,
                        child: Text('-',style: TextStyle(fontSize: 30)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 100,
                      width: 100,
                      color: Colors.white,
                      child: Center(
                        child: Text(_contador.toString(),style: TextStyle(fontSize: 30)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        setState(() {
                          _contador++;
                          print(_contador);
                        });
                      },
                      child: CircleAvatar(
                        maxRadius: 50,
                        child: Text('+',style: TextStyle(fontSize: 30)),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              GestureDetector(
                onTap:  () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('confirma que quer '+widget.adicionarOuBaixar+ ' ?'),
                        content: Text('texto adicional'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancelar'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('ok'),
                            onPressed: () async {
                              Navigator.of(context).pop();
                              sendApiNovoOuEdicao();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: WidgetsGlocais.botaoMaster(
                    context, AppController.instance.botaoConfirmar, 'salvar'),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: WidgetsGlocais.botaoMaster(
                    context, AppController.instance.botaoNegar, 'cancelar'),
              ),
            ],
          ),
        ));
  }

  Future<void> sendApiNovoOuEdicao() async {
    setState(() {
      _isLoading = true;
    });
    var url = '${VariaveisGlobais.endPoint}/produto/adicionar';
    String idColaborador = '${VariaveisGlobais.usuarioDto.id}';

    var body;

    var situacao = "ENTRADA";
    var resultado = _contador;
    if(widget.adicionarOuBaixar == 'baixar'){
      situacao = "SAIDA";
      resultado = -_contador;
    }

    body = jsonEncode({
        "objEntradaSaidaProduto" : [
          {
            "id" : widget.produtoList[0].id,
            "idUserDoUsuario" : idColaborador,
            "tipo" : situacao,
            "dataCadastro" : null,
            "quantidade" : resultado,
            "valorCusto" : 123.45
          }
        ]
    });
    var headers = {
      'Content-Type': 'application/json',
      'idUsuario': '${VariaveisGlobais.usuarioDto.id}',
      'idColaborador': idColaborador
    };
    var response = await http.post(Uri.parse(url), headers: headers, body: body);
    debugPrint(response.statusCode.toString());
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();

  }


}
