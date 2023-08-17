import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';
import 'package:intl/intl.dart';
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

  double tamanhoDaFonte = 16;

  late Produto produtoModelo;

  var fazendoRequest = false;
  int responseCodeDaRequest = 0;

  var revelarTodos = false;
  var editar = false;
  var edicaoDeProdutoAtivo = false;
  var idProduto = '';
  var _idProduto = TextEditingController();
  var _nomeProduto = TextEditingController();
  var _codigoProduto = TextEditingController();
  var _qtInicial = TextEditingController();
  var _custo = TextEditingController();
  var _vlDeVenda = TextEditingController();
  var _produtoAtivo = true;
  int _vlParaOEstoque = 1;

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
              : Text(_textoApareceEmCimaDaTela)),
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
                        if(widget.idProduto == VariaveisGlobais.NOVO_PRODUTO){
                          await enviarNovoProduto('NOVO');
                        }else{
                          await enviarNovoProduto('EDICAO');
                        }

                        if (responseCodeDaRequest == 409) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Ops... algo nao deu certo"),
                                content: Text("O código de produto já existe!"),
                                actions: [
                                  TextButton(
                                    child: Text("ok"),
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
                        style: TextStyle(fontSize: tamanhoDaFonte),
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
                        style: TextStyle(fontSize: tamanhoDaFonte),
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
                        style: TextStyle(fontSize: tamanhoDaFonte),
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
                        style: TextStyle(fontSize: tamanhoDaFonte),
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
            onPressed: ()  async {
              await excluirProdutoPorID(widget.idProduto);
              Navigator.of(context).pop();
            },
            backgroundColor: Colors.orange,
            label: Text(
              'excluir o produto',
              style: TextStyle(fontSize: tamanhoDaFonte),
            ),
            icon: Icon(Icons.ac_unit),
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
                        style: TextStyle(fontSize: tamanhoDaFonte),
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
                            Text(' mais ações', style: TextStyle(fontSize: tamanhoDaFonte)),
                          ],
                        )
                      : Row(
                          children: [
                            Icon(Icons.hide_source),
                            Text(' esconder ações',
                                style: TextStyle(fontSize: tamanhoDaFonte)),
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
                                style: TextStyle(fontSize: tamanhoDaFonte)),
                          )
                        : Container(),
                  ],
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('produto ativo',style: TextStyle(fontSize: tamanhoDaFonte),),
                      Switch(
                        value: _produtoAtivo,
                        onChanged: edicaoDeProdutoAtivo == false ? null : (value) {
                          setState(() {
                            _produtoAtivo = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(fontSize: tamanhoDaFonte),
                    enabled: false,
                    controller: _idProduto,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'id do produto',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(fontSize: tamanhoDaFonte),
                    enabled: editar,
                    controller: _nomeProduto,
                    decoration: buildInputDecoration('descrição do item'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(fontSize: tamanhoDaFonte),
                    controller: _codigoProduto,
                    enabled: editar,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: buildInputDecoration('código do item'),
                  ),
                ),
                widget.idProduto == VariaveisGlobais.NOVO_PRODUTO ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(fontSize: tamanhoDaFonte),
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
                ):Container(),
                widget.idProduto == VariaveisGlobais.NOVO_PRODUTO ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(fontSize: tamanhoDaFonte),
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
                ):Container(),
                widget.idProduto != VariaveisGlobais.NOVO_PRODUTO ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(fontSize: tamanhoDaFonte),
                    controller: TextEditingController(text: "AJUSTAR"),
                    enabled: false,
                    decoration: buildInputDecoration('estoque atual'),
                  ),
                ):Container(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    style: TextStyle(fontSize: tamanhoDaFonte),
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
                widget.idProduto == VariaveisGlobais.NOVO_PRODUTO ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                          child: Container(
                            color: Colors.red,
                            width: 120,
                            height: 50,
                            child: Icon(Icons.arrow_upward_outlined,color: Colors.white),
                          ),
                        ),
                        Container(
                          alignment: Alignment.center,
                          color: Colors.white10,
                          width: 50,
                          height: 50,
                          child: Text(_vlParaOEstoque.toString(), style: TextStyle(fontSize: 30)),
                        ),
                        GestureDetector(
                          child: Container(
                            color: Colors.green,
                            width: 120,
                            height: 50,
                            child: Icon(Icons.arrow_downward_outlined,color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ) : Container(),
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

  Future<void> enviarNovoProduto(String tipoNovoOuEdicao) async {
    setState(() {
      fazendoRequest = true;
    });
    var url = '${VariaveisGlobais.endPoint}/produto/cadastro';
    String idDeQuemEstaCadastrando = '${VariaveisGlobais.usuarioDto.id}';

    String headerDoTipo;
    var body;
    String id = '';

    if(tipoNovoOuEdicao == 'NOVO'){
      headerDoTipo = 'NOVO';

    }else{
      headerDoTipo = 'EDICAO';
      id = widget.idProduto;
    }

    body = jsonEncode({
      "id" : id,
      "ativo": _produtoAtivo,
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
      "precoVenda": VariaveisGlobais.converterMoedaEmDoble(_vlDeVenda.text),
      "objComissao": {
        "produtoTemComissaoEspecial": false,
        "valorFixoDeComissaoParaEsseProduto": 10.00
      },
      "objEntradaSaidaProduto": [
        {
          "quantidade": _qtInicial.text,
          "valorCusto": VariaveisGlobais.converterMoedaEmDoble(_custo.text),
          "valorDaVenda": VariaveisGlobais.converterMoedaEmDoble(_vlDeVenda.text)
        }
      ],
      "objLogs": [
        {
          "objInformacoesDoCadastro": {
            "idDeQuemCadastrou": '${VariaveisGlobais.usuarioDto.id}',
            "dataCadastro": null
          },
          "ocorrencia": "CADASTRO"
        }
      ]
    });

    var headers = {
      'Content-Type': 'application/json',
      'idUsuario': '${VariaveisGlobais.usuarioDto.id}',
      'idColaborador': idDeQuemEstaCadastrando,
      'tipoNovoOuEditar' : headerDoTipo
    };

    var response = await http.post(Uri.parse(url), headers: headers, body: body);
    debugPrint(response.statusCode.toString());

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
      _idProduto = TextEditingController(text: widget.idProduto);
      _nomeProduto = TextEditingController(text: produtoModelo.nomeProduto);
      _codigoProduto = TextEditingController(text: produtoModelo.codigoDeBarras);
      _vlDeVenda = TextEditingController(text: NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(produtoModelo.precoVenda));
      _produtoAtivo = produtoModelo.ativo;
    }

    setState(() {
      fazendoRequest = false;
      responseCodeDaRequest = response.statusCode;
    });
  }

  Future<void> excluirProdutoPorID (String id) async {
    setState(() {
      fazendoRequest = true;
    });
    var url = '${VariaveisGlobais.endPoint}/produto/apagar/' + id;
    String idDeQuemEstaCadastrando = '${VariaveisGlobais.usuarioDto.id}';
    var headers = {
      'Content-Type': 'application/json',
      'idUsuario': '${VariaveisGlobais.usuarioDto.id}',
      'idColaborador': idDeQuemEstaCadastrando
    };
    var response = await http.delete(Uri.parse(url), headers: headers);

    if (response.statusCode == 200) {

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
