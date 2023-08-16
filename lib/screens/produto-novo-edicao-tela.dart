import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';

import '../dtos/produto_dto.dart';

class ProdutoNovoEdicaoTela extends StatefulWidget {
  String idProduto;

  ProdutoNovoEdicaoTela({Key? key, required this.idProduto}) : super(key: key);

  @override
  State<ProdutoNovoEdicaoTela> createState() => _ProdutoNovoEdicaoTelaState();
}

class AdicionarOuBaixar extends StatefulWidget {
  final String adicionarOuBaixar;
  final String idProduto;

  const AdicionarOuBaixar(this.adicionarOuBaixar, this.idProduto, {Key? key})
      : super(key: key);

  @override
  State<AdicionarOuBaixar> createState() => _AdicionarOuBaixarState();
}

class _ProdutoNovoEdicaoTelaState extends State<ProdutoNovoEdicaoTela> {
  final _form = GlobalKey<FormState>(); // cria  a chave para o formulario

  late Produto produtoModelo;

  var fazendoRequest = false;
  int responseCodeDaRequest = 0;

  var revelarTodos = false;
  var editar = false;
  var edicaoDeProdutoAtivo = false;
  var idProduto = '';
  final _idProduto = TextEditingController();
  final _nomeProduto = TextEditingController();
  final _codigoProduto = TextEditingController();
  var _qtInicial = TextEditingController();
  final _custo = TextEditingController();
  final _vlDeVenda = TextEditingController();

  String _textoApareceEmCimaDaTela = '';

  @override
  void initState() {
    if (widget.idProduto != VariaveisGlobais.NOVO_PRODUTO) {
      pesquisarOProduto(widget.idProduto);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.idProduto);
    setState(() {
      if (widget.idProduto == VariaveisGlobais.NOVO_PRODUTO) {
        _textoApareceEmCimaDaTela = 'novo produto';
        edicaoDeProdutoAtivo = true;
        editar = true;
      } else {
        _textoApareceEmCimaDaTela = 'edição';
      }
    });

    return Scaffold(
      appBar: AppBar(
          title: edicaoDeProdutoAtivo == true
              ? Text(_textoApareceEmCimaDaTela)
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
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text("continuar"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                        if (responseCodeDaRequest == 200) {
                          Navigator.pop(context);
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
                            child: Text(_textoApareceEmCimaDaTela,
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
                    decoration: buildInputDecoration('descrição do item'),
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
                    decoration: buildInputDecoration('código do item'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _qtInicial,
                    enabled: editar,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d{0,8}(\.\d{0,2})?$')),
                    ],
                    decoration:
                        buildInputDecoration('quantidade da entrada inicial'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _custo,
                    enabled: editar,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d{0,8}(\.\d{0,2})?$')),
                    ],
                    decoration: buildInputDecoration('custo'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _vlDeVenda,
                    enabled: editar,
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d{0,8}(\.\d{0,2})?$')),
                    ],
                    decoration: buildInputDecoration('valor da venda'),
                  ),
                ),
              ],
            ),
    );
  }

  InputDecoration buildInputDecoration(String texto) {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(60)),
      enabledBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(60)),
      focusedBorder:
          OutlineInputBorder(borderRadius: BorderRadius.circular(60)),
      labelText: texto,
    );
  }

  Future<void> enviarNovoProduto() async {
    setState(() {
      fazendoRequest = true;
    });
    var url = '${VariaveisGlobais.endPoint}/produto/cadastro';
    String idDeQuemEstaCadastrando = '${VariaveisGlobais.usuarioDto.id}';
    var headers = {
      'Content-Type': 'application/json',
      'idUsuario': '${VariaveisGlobais.usuarioDto.id}',
      'idColaborador': idDeQuemEstaCadastrando
    };
    var body = jsonEncode({
      "ativo": true,
      "codigoDeBarras": _codigoProduto.text,
      "nomeProduto": _nomeProduto.text,
      "tipoPoduto": "PRODUTO",
      "objInformacoesDoCadastro": {
        "idDeQuemCadastrou": idDeQuemEstaCadastrando
      },
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
        {
          "quantidade": _qtInicial.text,
          "valorCusto": _custo.text,
          "valorDaVenda": _vlDeVenda.text
        }
      ],
      "objLogs": [
        {
          "objInformacoesDoCadastro": {
            "idDeQuemCadastrou": '${VariaveisGlobais.usuarioDto.id}',
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

  Future<void> pesquisarOProduto(String id) async {
    debugPrint('pesquisarOProduto');
    setState(() {
      fazendoRequest = true;
    });
    var url = '${VariaveisGlobais.endPoint}/produto/detalhado/' + id;
    String idDeQuemEstaCadastrando = '${VariaveisGlobais.usuarioDto.id}';
    var headers = {
      'Content-Type': 'application/json',
      'idUsuario': '${VariaveisGlobais.usuarioDto.id}',
      'idColaborador': idDeQuemEstaCadastrando
    };
    var response = await http.get(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      produtoModelo = Produto.fromJson(jsonResponse);
    }

    setState(() {
      fazendoRequest = false;
      responseCodeDaRequest = response.statusCode;
    });
  }
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
