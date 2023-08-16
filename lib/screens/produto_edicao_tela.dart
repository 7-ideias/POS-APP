import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class ProdutoDetalheTela extends StatefulWidget {
  String idProduto;

  ProdutoDetalheTela({Key? key, required this.idProduto}) : super(key: key);

  @override
  State<ProdutoDetalheTela> createState() => _ProdutoDetalheTelaState();
}

class _ProdutoDetalheTelaState extends State<ProdutoDetalheTela> {
  final _form = GlobalKey<FormState>(); // cria  a chave para o formulario

  bool fazendoRequest = false;
  int responseCodeDaRequest = 0;

  bool revelarTodos = false;
  bool editar = false;
  bool edicaoDeProdutoAtivo = false;
  var idProduto = '';
  var _idProduto = TextEditingController();
  var _nomeProduto = TextEditingController();
  var _codigoProduto = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: edicaoDeProdutoAtivo == true
              ? Text('edicao')
              : Text(widget.idProduto)),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              edicaoDeProdutoAtivo == true
                  ? FloatingActionButton.extended(
                      onPressed: () async {
                         await enviarNovoProduto();
                        if (responseCodeDaRequest == 409) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Ops... algo nao deu certo"),
                                content: Text("O código de produto já existe!"),
                                actions: [
                                  TextButton(
                                    child: Text("cancelar"),
                                    onPressed:  () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text("continuar"),
                                    onPressed:  () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      backgroundColor: Colors.green,
                      label: Text(
                        'salvar',
                        style: TextStyle(fontSize: 22),
                      ),
                      icon: Icon(Icons.save),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    )
                  : Container(),
              SizedBox(
                width: 20,
              ),
              edicaoDeProdutoAtivo == true
                  ? FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      backgroundColor: Colors.redAccent,
                      label: Text(
                        'cancelar',
                        style: TextStyle(fontSize: 22),
                      ),
                      icon: Icon(Icons.cancel),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    )
                  : Container(),
            ],
          ),
          edicaoDeProdutoAtivo == false
              ? (revelarTodos == true
                  ? FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AdicionarOuBaixar('adicionar', idProduto)),
                        );
                      },
                      backgroundColor: Colors.green,
                      label: Text(
                        'adicionar mais ao estoque',
                        style: TextStyle(fontSize: 22),
                      ),
                      icon: Icon(Icons.add),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    )
                  : Container())
              : Container(),
          SizedBox(
            height: 10,
          ),
          edicaoDeProdutoAtivo == false
              ? (revelarTodos == true
                  ? FloatingActionButton.extended(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AdicionarOuBaixar('baixar', idProduto)),
                        );
                      },
                      backgroundColor: Colors.red,
                      label: Text(
                        'dar baixar (diminuir) estoque',
                        style: TextStyle(fontSize: 22),
                      ),
                      icon: Icon(Icons.remove),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    )
                  : Container())
              : Container(),
          SizedBox(
            height: 10,
          ),
          edicaoDeProdutoAtivo == false
              ? (revelarTodos == true
                  ? FloatingActionButton.extended(
                      onPressed: () {
                        setState(() {
                          editar = !editar;
                          edicaoDeProdutoAtivo = !edicaoDeProdutoAtivo;
                        });
                      },
                      label: Text(
                        'editar o produto',
                        style: TextStyle(fontSize: 22),
                      ),
                      icon: Icon(Icons.edit),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    )
                  : Container())
              : Container(),
          SizedBox(
            height: 10,
          ),
          edicaoDeProdutoAtivo == false
              ? FloatingActionButton.extended(
                  onPressed: () {
                    setState(() {
                      revelarTodos = !revelarTodos;
                    });
                  },
                  label: revelarTodos == false
                      ? Row(
                          children: [
                            Icon(Icons.add),
                            Text(' mais ações', style: TextStyle(fontSize: 22)),
                          ],
                        )
                      : Row(
                          children: [
                            Icon(Icons.hide_source),
                            Text(' esconder ações',
                                style: TextStyle(fontSize: 22)),
                          ],
                        ),
                )
              : Container(),
        ],
      ),
      body: fazendoRequest == true
          ? Center(
              child: fazendoRequest
                  ? Lottie.asset('assets/loading.json')
                  : (responseCodeDaRequest == 200
                      ? Lottie.asset('assets/success-mark.json')
                      : Lottie.asset('assets/failed-button.json')))
          : ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    edicaoDeProdutoAtivo == true
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('editando o produto',
                                style: TextStyle(fontSize: 22)),
                          )
                        : Container(),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    enabled: false,
                    controller: _idProduto,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Digite um texto',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    enabled: editar,
                    controller: _nomeProduto,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'nome produto',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _codigoProduto,
                    enabled: editar,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Digite um número',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    enabled: editar,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d{0,8}(\.\d{0,2})?$')),
                    ],
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Digite um número',
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> enviarNovoProduto() async {
    setState(() {
      fazendoRequest = true;
    });
    var url = 'http://sixbackend-70ed1c73ebec.herokuapp.com/produto/cadastro';
    var headers = {
      'Content-Type': 'application/json',
      'idUsuario': '40eb39abc2f44908ae5dfc16687cc977',
      'idColaborador': '40eb39abc2f44908ae5dfc16687cc977'
    };
    var body = jsonEncode({
      "ativo": true,
      "codigoDeBarras": _codigoProduto.text,
      "nomeProduto": _nomeProduto.text,
      "tipoPoduto": "PRODUTO",
      "objInformacoesDoCadastro": {"idDeQuemCadastrou": "idDeQuemCadastrou"},
      "objAgrupamento": {"grupoDoProduto": "grupoDoProduto"},
      "objetoServico": {
        "tempoDaGarantia": "tempoDaGarantia",
        "podeAlterarOValorNaHora": false
      },
      "modeloProduto": "UNIDADE, KILO, SEM_MODELO",
      "estoqueMaximo": 50,
      "estoqueMinimo": 10,
      "precoVenda": 300.50,
      "objComissao": {
        "produtoTemComissaoEspecial": false,
        "valorFixoDeComissaoParaEsseProduto": 10.00
      },
      "objEntradaSaidaProduto": [
        {"quantidade": 10.99, "valorCusto": 5.99, "valorDaVenda": 10.99}
      ],
      "objLogs": [
        {
          "objInformacoesDoCadastro": {
            "idDeQuemCadastrou": "idDeQuemCadastrou",
            "dataCadastro": null
          },
          "ocorrencia": "ocorrencia"
        }
      ]
    });

    var response =
        await http.post(Uri.parse(url), headers: headers, body: body);
    print(response.statusCode);
    print(response.body);

    setState(() {
      fazendoRequest = false;
      responseCodeDaRequest = response.statusCode;
    });

  }
}

class AdicionarOuBaixar extends StatefulWidget {
  final String adicionarOuBaixar;
  final String idProduto;

  const AdicionarOuBaixar(this.adicionarOuBaixar, this.idProduto, {Key? key})
      : super(key: key);

  @override
  State<AdicionarOuBaixar> createState() => _AdicionarOuBaixarState();
}

class _AdicionarOuBaixarState extends State<AdicionarOuBaixar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.adicionarOuBaixar),
      ),
      body: Column(
        children: [],
      ),
    );
  }
}
