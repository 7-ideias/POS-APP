import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_app/controller/app_controller.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';
import 'package:pos_app/utilitarios/widgetsGlobais.dart';

import '../dtos/produto-dto.dart';
import '../utilitarios/utils.dart';

class ProdutoNovoEdicaoTela extends StatefulWidget {
  String idProduto;

  ProdutoNovoEdicaoTela({Key? key, required this.idProduto}) : super(key: key);

  @override
  State<ProdutoNovoEdicaoTela> createState() => _ProdutoNovoEdicaoTelaState();
}


class _ProdutoNovoEdicaoTelaState extends State<ProdutoNovoEdicaoTela> {
  final _form = GlobalKey<FormState>(); // cria  a chave para o formulario

  double tamanhoDaFonte = 20;
  late ProdutoDto produtoModelo;
  var fazendoRequest = false;
  int responseCodeDaRequest = 0;
  String _textoApareceEmCimaDaTela = '';
  var revelarTodos = false;
  var editar = false;
  var edicaoDeProdutoAtivo = false;

  var idProduto = '';
  var _idProduto = TextEditingController();
  var _nomeProduto = TextEditingController();
  var _codigoProduto = TextEditingController();
  var _qtInicial = TextEditingController();
  var _modeloProduto = TextEditingController();
  var _custo = TextEditingController();
  var _vlDeVenda = TextEditingController();
  var _estoqueMaximo = TextEditingController();
  var _estoqueMinino = TextEditingController();
  var _produtoAtivo = true;
  var _comissao = false;
  var _vlDaComissao = TextEditingController();


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
      backgroundColor: AppController.instance.corTelaFundo,
      appBar: AppBar(
          title: edicaoDeProdutoAtivo == true
              ? Text(_textoApareceEmCimaDaTela)
              : Text(_textoApareceEmCimaDaTela),
      actions: [
        edicaoDeProdutoAtivo == false ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: (){
                excluirProdutoPorID(widget.idProduto);
              },
              child: Icon(Icons.traffic_sharp, color: AppController.instance.corLetras,
                size: 30,)),
        ) : Container(),
        edicaoDeProdutoAtivo == false ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: (){
                setState(() {
                  prepararCamposParaEdicao();
                });
              },
              child: Icon(Icons.edit, color: AppController.instance.corLetras,
              size: 30,)),
        ) : Container()
      ],
      ),
      body: fazendoRequest == true
          ? Center(
              child: fazendoRequest
                  ? Lottie.asset('assets/loading.json')
                  : (responseCodeDaRequest == 200
                      ? Lottie.asset('assets/success-mark.json')
                      : Lottie.asset('assets/failed-button.json')))
          : Padding(
            padding: const EdgeInsets.only(left: 8,right: 8,top: 10,bottom: 10),
            child: Container(
        color: AppController.instance.corTelaAcima,
              child: Form(
                key: _form,
                child: ListView(
                    children: [
                      widget.idProduto == VariaveisGlobais.NOVO_PRODUTO ? Container() :Stack(
                        alignment: Alignment.center,
                        children: [
                          Card(
                            color: AppController.instance.corTelaAcima,
                            elevation: 10,
                            child: Container(
                              color: Colors.purple,
                              height: 200,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 50,
                                    ),
                                  ),
                                  Text('qt no estoque.: '+ produtoModelo.objCalculosDeProdutoDoBackEnd.qtNoEstoque.toStringAsFixed(0),style: TextStyle(fontSize: tamanhoDaFonte,color: AppController.instance.corLetras),),
                                  Text('vl estoque em grana.: '+Utils.formatPrice(produtoModelo.objCalculosDeProdutoDoBackEnd.vlEstoqueEmGrana).toString(),style: TextStyle(fontSize: tamanhoDaFonte,color: AppController.instance.corLetras),),
                                  Text('ultimo preço pago.: '+Utils.formatPrice(produtoModelo.objCalculosDeProdutoDoBackEnd.ultimoVlEmGranaPagoPeloProduto).toString(),style: TextStyle(fontSize: tamanhoDaFonte,color: AppController.instance.corLetras),),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      //produto ativo
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('produto ativo',style: TextStyle(fontSize: tamanhoDaFonte,color: AppController.instance.corLetras),),
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
                      //descricao do item
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'não deixe isso vazio';
                            }
                            return null;
                          },
                          style: TextStyle(fontSize: tamanhoDaFonte,color: AppController.instance.corLetras),
                          enabled: editar,
                          controller: _nomeProduto,
                          decoration: buildInputDecoration('descrição do item'),
                        ),
                      ),
                      //codigo de barras ou codigo do item
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'não deixe isso vazio';
                            }
                            return null;
                          },
                          style: TextStyle(fontSize: tamanhoDaFonte,color: AppController.instance.corLetras),
                          controller: _codigoProduto,
                          enabled: editar,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          decoration: buildInputDecoration('código do item'),
                        ),
                      ),
                      //qt entrando no estoque
                      widget.idProduto == VariaveisGlobais.NOVO_PRODUTO ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'não deixe isso vazio';
                            }
                            return null;
                          },
                          style: TextStyle(fontSize: tamanhoDaFonte,color: AppController.instance.corLetras),
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


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: //custo
                            widget.idProduto == VariaveisGlobais.NOVO_PRODUTO ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'não deixe isso vazio';
                                  }
                                  return null;
                                },
                                style: TextStyle(fontSize: tamanhoDaFonte,color: AppController.instance.corLetras),
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
                          ),
                          //valor da venda
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child:
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'não deixe isso vazio';
                                  }
                                  return null;
                                },
                                style: TextStyle(fontSize: tamanhoDaFonte,color: AppController.instance.corLetras),
                                controller: _vlDeVenda,
                                enabled: editar,
                                keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d{0,8}(\.\d{0,2})?$')),
                                ],
                                decoration: buildInputDecoration('preço'),
                              ),
                            ),
                          ),
                        ],
                      ),


                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'não deixe isso vazio';
                                }
                                return null;
                              },
                                style: TextStyle(fontSize: tamanhoDaFonte,color: AppController.instance.corLetras),
                                controller: _estoqueMinino,
                                enabled: editar,
                                keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d{0,8}(\.\d{0,2})?$')),
                                ],
                                decoration:
                                buildInputDecoration('estoque mínimo'),
                              ),
                            ) ,
                          ),
                          //valor da venda
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child:
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'não deixe isso vazio';
                                  }
                                  return null;
                                },
                                style: TextStyle(fontSize: tamanhoDaFonte,color: AppController.instance.corLetras),
                                controller: _estoqueMaximo,
                                enabled: editar,
                                keyboardType:
                                TextInputType.numberWithOptions(decimal: true),
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'^\d{0,8}(\.\d{0,2})?$')),
                                ],
                                decoration:
                                buildInputDecoration('estoque máximo'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(
                        color: Colors.white,
                        height: 5,
                        thickness: 5,
                      ),

                      //produto com comissao ao vendedor
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('comissao ao vendedor?',style: TextStyle(fontSize: tamanhoDaFonte,color: AppController.instance.corLetras),),
                            Switch(
                              value: _comissao,
                              onChanged: (value) {
                                setState(() {
                                  _comissao = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      //valor da comissao
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: TextStyle(fontSize: tamanhoDaFonte,color: AppController.instance.corLetras),
                          controller: _vlDaComissao,
                          enabled: editar,
                          keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^\d{0,8}(\.\d{0,2})?$')),
                          ],
                          decoration: buildInputDecoration('valor da comissao'),
                        ),
                      ),
                      edicaoDeProdutoAtivo == false ? Container() :botoesSalvarECancelar(context),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
              ),
            ),
          ),
    );
  }

  Widget botoesSalvarECancelar(BuildContext context) {
    print(_vlDeVenda.text);
    return Column(
                children: [
                  GestureDetector(
                    onTap: ()async {
                      if (_form.currentState!.validate()) {
                        if(widget.idProduto == VariaveisGlobais.NOVO_PRODUTO){
                          await enviarApiNovoOuEdicao('NOVO');
                        }else{
                          await enviarApiNovoOuEdicao('EDICAO');
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
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('no else')),
                        );
                      }

                    },
                    child: WidgetsGlocais.botaoMaster(context, AppController.instance.botaoConfirmar,
                        'salvar'),
                  ),
                  GestureDetector(
                    onTap: (){
                        setState(() {
                          edicaoDeProdutoAtivo = false;
                        });
                        Navigator.pop(context);
                    },
                    child: WidgetsGlocais.botaoMaster(context, AppController.instance.botaoNegar,
                        'cancelar'),
                  ),
                ],
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

  Future<void> enviarApiNovoOuEdicao(String novoOuEdicao) async {
    setState(() {
      fazendoRequest = true;
    });
    var url = '${VariaveisGlobais.endPoint}/produto/cadastro';
    String idDeQuemEstaCadastrando = '${VariaveisGlobais.usuarioDto.id}';

    String headerDoTipo;
    var body;
    String id = '';

    if(novoOuEdicao == 'NOVO'){
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
      "tipoPoduto": widget.idProduto == VariaveisGlobais.NOVO_PRODUTO ? "PRODUTO" : "SERVICO",
      "objInformacoesDoCadastro": {
        "idDeQuemCadastrou": idDeQuemEstaCadastrando
      },
      "objAgrupamento": {"grupoDoProduto": "grupoDoProduto"},
      "objetoServico": {
        "tempoDaGarantia": "tempoDaGarantia",
        "podeAlterarOValorNaHora": false
      },
      "modeloProduto": "UNIDADE, KILO, SEM_MODELO",
      "estoqueMaximo": _estoqueMaximo.text,
      "estoqueMinimo": _estoqueMinino.text,
      "precoVenda":  VariaveisGlobais.converterMoedaEmDoble(_vlDeVenda.text),
      "objComissao": {
        "produtoTemComissaoEspecial": _comissao,
        "valorFixoDeComissaoParaEsseProduto": _vlDaComissao.text
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
      produtoModelo = ProdutoDto.fromJson(jsonResponse);

      _idProduto = TextEditingController();
      _codigoProduto = TextEditingController(text: produtoModelo.codigoDeBarras);
      _nomeProduto = TextEditingController(text: produtoModelo.nomeProduto);
      _vlDeVenda = TextEditingController(text: NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(produtoModelo.precoVenda));
      _produtoAtivo = produtoModelo.ativo;

      _modeloProduto = TextEditingController(text: produtoModelo.modeloProduto);
      _estoqueMaximo = TextEditingController(text: produtoModelo.estoqueMaximo.toString());
      _estoqueMinino = TextEditingController(text: produtoModelo.estoqueMinimo.toString());

      _produtoAtivo = true;
      _comissao = produtoModelo.objComissao.produtoTemComissaoEspecial!;
      _vlDaComissao = TextEditingController(text: produtoModelo.objComissao.valorFixoDeComissaoParaEsseProduto.toString());

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

  void prepararCamposParaEdicao() {
    editar = !editar;
    edicaoDeProdutoAtivo = !edicaoDeProdutoAtivo;
    _vlDeVenda = TextEditingController(text: NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$').format(produtoModelo.precoVenda));
  }

}

