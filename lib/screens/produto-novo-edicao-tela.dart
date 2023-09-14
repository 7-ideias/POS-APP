import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:pos_app/controller/app_controller.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';
import 'package:pos_app/utilitarios/tela_inteira.dart';
import 'package:pos_app/utilitarios/widgetsGlobais.dart';

import '../dtos/produto-dto.dart';
import '../utilitarios/moeda_formatador.dart';
import '../utilitarios/texto_ajuda.dart';
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
  // var _qtInicial = TextEditingController();
  var _modeloProduto = TextEditingController();
  var _custo = TextEditingController();
  var _vlDeVenda = TextEditingController();
  var _estoqueMaximo = 1;
  var _estoqueMinino = 1;
  var _produtoAtivo = true;
  var _comissao = false;
  var _vlDaComissao = TextEditingController(text: '0.00');

  var _qtEstoqueInicial = 1;

  String resultadoDoSacanner = '';

  Barcode? scannedBarcode;

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
        automaticallyImplyLeading: false,
          title: Center(
            child: edicaoDeProdutoAtivo == true
                ? Text(_textoApareceEmCimaDaTela)
                : Text(_textoApareceEmCimaDaTela),
          ),
      actions: [
        edicaoDeProdutoAtivo == false ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: (){
                setState(() {
                  prepararCamposParaEdicao();
                });
              },
              child: Icon(Icons.edit,
              size: 30,)),
        ) : Container()
      ],
      ),
      body: fazendoRequest == true
          ? responseCodeDaRequest == 200 ? TelaInteira().sucesso() : TelaInteira().widgetDeLoadingPadraoDoApp()
          : Container(
        alignment: Alignment.center,
            child: Form(
              key: _form,
              child: SingleChildScrollView(
                child: Column(
                    children: [
                      //só aparece esse card na edicao
                      widget.idProduto == VariaveisGlobais.NOVO_PRODUTO ? Container() :Stack(
                        alignment: Alignment.center,
                        children: [
                          Card(
                            elevation: 10,
                            child: Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircleAvatar(
                                      child: Icon(Icons.question_mark,size: 30,),
                                      radius: 50,
                                    ),
                                  ),
                                  Text('qt no estoque.: '+ produtoModelo.objCalculosDeProdutoDoBackEnd.qtNoEstoque.toStringAsFixed(0),style: TextStyle(fontSize: tamanhoDaFonte,),),
                                  Text('vl estoque em grana.: '+Utils.formataParaMoeda(produtoModelo.objCalculosDeProdutoDoBackEnd.vlEstoqueEmGrana).toString(),style: TextStyle(fontSize: tamanhoDaFonte,),),
                                  Text('ultimo preço pago.: '+Utils.formataParaMoeda(produtoModelo.objCalculosDeProdutoDoBackEnd.ultimoVlEmGranaPagoPeloProduto).toString(),style: TextStyle(fontSize: tamanhoDaFonte,),),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20,),

                      //produto ativo
                      _nomeProduto.text.length > 0 && _codigoProduto.text.length > 0 ? Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('produto ativo',style: TextStyle(fontSize: tamanhoDaFonte,),),
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
                      ):Container(),

                      //codigo de barras ou codigo do item
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (v){
                            setState(() {

                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'não deixe isso vazio';
                            }
                            return null;
                          },
                          style: TextStyle(fontSize: tamanhoDaFonte,),
                          controller: _codigoProduto,
                          enabled: editar,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(60)),
                            // enabledBorder:
                            // OutlineInputBorder(borderRadius: BorderRadius.circular(60)),
                            // focusedBorder:
                            // OutlineInputBorder(borderRadius: BorderRadius.circular(60)),
                            labelText: 'código de barras',
                            suffixIcon: GestureDetector(
                                onTap: (){
                                  scan();
                                },
                                child: Icon(Icons.qr_code_2_outlined))

                          ),

                        ),
                      ),

                      //descricao do item
                      _codigoProduto.text.length > 0 ?
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          onChanged: (v){
                            setState(() {

                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'não deixe isso vazio';
                            }
                            return null;
                          },
                          style: TextStyle(fontSize: tamanhoDaFonte,),
                          enabled: editar,
                          controller: _nomeProduto,
                          decoration: buildInputDecoration('descrição do item'),
                        ),
                      ): Container(),
                      //custo e preco
                      if(_nomeProduto.text.length > 0 && _codigoProduto.text.length > 0)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              border:  Border.all(
                              )
                          ),
                          child: Column(
                            children: [
                              Text('preços'),
                              Row(
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    child: //custo
                                    widget.idProduto == VariaveisGlobais.NOVO_PRODUTO ? Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        validator: (value) {
                                          print('value ------>'+value.toString());
                                          if (value == null || value.isEmpty) {
                                            return 'não deixe isso vazio';
                                          }
                                          return null;
                                        },
                                        textAlign: TextAlign.end,
                                        style: TextStyle(fontSize: tamanhoDaFonte),
                                        controller: _custo,
                                        enabled: editar,
                                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                                        inputFormatters: [ FilteringTextInputFormatter.digitsOnly, FormatadorDeMoeda(),
                                        ],
                                        decoration: buildInputDecoration('custo'),
                                      ),
                                    ):Container(),
                                  ),
                                  Spacer(),
                                  //valor da venda
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    child:
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: TextFormField(
                                        validator: (value) {
                                          print('value ------>'+value.toString());
                                          if (value == null || value.isEmpty) {
                                            return 'não deixe isso vazio';
                                          }
                                          return null;
                                        },
                                        textAlign: TextAlign.end,
                                        style: TextStyle(fontSize: tamanhoDaFonte),
                                        controller: _vlDeVenda,
                                        enabled: editar,
                                        keyboardType: TextInputType.numberWithOptions(decimal: true),
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly, FormatadorDeMoeda()
                                        ],
                                        decoration: buildInputDecoration('preço'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      //qt inicial
                      if(_nomeProduto.text.length > 0 && widget.idProduto == VariaveisGlobais.NOVO_PRODUTO)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(30)),
                                border:  Border.all(
                                )
                            ),
                            child: Column(
                              children: [
                                Text('quantidade inicial'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          _qtEstoqueInicial <= 1 ? _qtEstoqueInicial : _qtEstoqueInicial--;
                                        });
                                      },
                                      onLongPress: (){
                                        setState(() {
                                          if(_qtEstoqueInicial>10){
                                            _qtEstoqueInicial = _qtEstoqueInicial-10;
                                          }
                                        });
                                      },
                                      child: CircleAvatar(
                                        maxRadius: 25,
                                        child: Text('-',style: TextStyle(fontSize: 30)),
                                      ),
                                    ),
                                    Container(
                                      height: 100,
                                      width: 100,
                                      child: Center(
                                        child: Text(_qtEstoqueInicial.toString(),style: TextStyle(fontSize: 30)),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          _qtEstoqueInicial++;
                                          print(_qtEstoqueInicial);
                                        });
                                      },
                                      onLongPress: (){
                                        setState(() {
                                          _qtEstoqueInicial = _qtEstoqueInicial+10;
                                        });
                                      },
                                      child: CircleAvatar(
                                        maxRadius: 25,
                                        child: Text('+',style: TextStyle(fontSize: 30)),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      //qtidade minima
                      _nomeProduto.text.length > 0 && widget.idProduto == VariaveisGlobais.NOVO_PRODUTO ?
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              border:  Border.all(
                              )
                          ),
                          child: Column(
                            children: [
                              Text('estoque mínimo'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          _estoqueMinino <= 1 ? _estoqueMinino : _estoqueMinino--;
                                          print(_estoqueMinino);
                                        });
                                      },
                                      child: CircleAvatar(
                                        maxRadius: 25,
                                        child: Text('-',style: TextStyle(fontSize: 30)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      child: Center(
                                        child: Text(_estoqueMinino.toString(),style: TextStyle(fontSize: 30)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          _estoqueMinino++;
                                          print(_estoqueMinino);
                                        });
                                      },
                                      child: CircleAvatar(
                                        maxRadius: 25,
                                        child: Text('+',style: TextStyle(fontSize: 30)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ):Container(),

                      //qtidade maxima no estoque
                      _nomeProduto.text.length > 0 && widget.idProduto == VariaveisGlobais.NOVO_PRODUTO ?
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              border:  Border.all(
                              )
                          ),
                          child: Column(
                            children: [
                              Text('estoque máximo'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          _estoqueMaximo <= 1 ? _estoqueMaximo : _estoqueMaximo--;
                                          print(_estoqueMaximo);
                                        });
                                      },
                                      child: CircleAvatar(
                                        maxRadius: 25,
                                        child: Text('-',style: TextStyle(fontSize: 30)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 100,
                                      width: 100,
                                      child: Center(
                                        child: Text(_estoqueMaximo.toString(),style: TextStyle(fontSize: 30)),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: GestureDetector(
                                      onTap: (){
                                        setState(() {
                                          _estoqueMaximo++;
                                          print(_estoqueMaximo);
                                        });
                                      },
                                      child: CircleAvatar(
                                        maxRadius: 25,
                                        child: Text('+',style: TextStyle(fontSize: 30)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ):Container(),

                      _nomeProduto.text.length > 0 && _codigoProduto.text.length > 0 ? Divider(
                        color: Colors.white,
                        height: 5,
                        thickness: 5,
                      ):Container(),

                      //produto com comissao ao vendedor
                      _nomeProduto.text.length > 0 && _codigoProduto.text.length > 0 ? Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('comissao ao vendedor?',style: TextStyle(fontSize: tamanhoDaFonte,),),
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
                      ):Container(),

                      //valor da comissao
                      _comissao==true && _nomeProduto.text.length > 0 && _codigoProduto.text.length > 0 ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          style: TextStyle(fontSize: tamanhoDaFonte,),
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
                      ):Container(),

                      SizedBox(height: 30),

                      if(edicaoDeProdutoAtivo == true) botoesSalvarECancelar(context),

                      SizedBox(height: 30),

                      if (widget.idProduto != VariaveisGlobais.NOVO_PRODUTO) getLogs(),
                    ],
                  ),
              ),
            ),
          ),
      floatingActionButton: UtilsWidgets.floatDeAjuda(context,
          _codigoProduto.text.isEmpty? 'os campos aparecem aos poucos!\n\nComece informando o códgo do produto' : 'ao informar os campos obrigatórios, outros irão aparecer'),
    );
  }


  //TODO FAZER A IMPLEMENTACAO DOS LOGS
  Widget getLogs(){
    return Container(child: Column(children: [
      Text('logs do produto'),
      // ListView.builder(scrollDirection: Axis.vertical,
      //     shrinkWrap: true,
      //     itemCount: produtoModelo.LOGS AINDA NAO EXISTEM,
      //     itemBuilder: (context, index) {
      //
      //     }
      // ),
    ],),);
  }

  Widget botoesSalvarECancelar(BuildContext context) {
    print(_vlDeVenda.text);
    return Column(
                children: [
                  _nomeProduto.text.length > 0 && _codigoProduto.text.length > 0 ? GestureDetector(
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
                    child: UtilsWidgets.botaoMaster(context, AppController.instance.botaoConfirmar,
                        'salvar'),
                  ):Container(),
                  GestureDetector(
                    onTap: (){
                        setState(() {
                          edicaoDeProdutoAtivo = false;
                        });
                        Navigator.pop(context);
                    },
                    child: UtilsWidgets.botaoMaster(context, AppController.instance.botaoNegar,
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
    String idDeQuemEstaCadastrando = '${VariaveisGlobais.usuarioDto.idUsuario}';

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
      "estoqueMaximo": _estoqueMaximo,
      "estoqueMinimo": _estoqueMinino,
      "precoVenda":  Utils.converterMoedaEmDoble(_vlDeVenda.text),
      "objComissao": {
        "produtoTemComissaoEspecial": _comissao,
        "valorFixoDeComissaoParaEsseProduto": _vlDaComissao.text
      },
      "objEntradaSaidaProduto": [
        {
          "quantidade": _qtEstoqueInicial,
          "valorCusto": Utils.converterMoedaEmDoble(_custo.text),
          "valorDaVenda": Utils.converterMoedaEmDoble(_vlDeVenda.text)
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
    String idDeQuemEstaCadastrando = '${VariaveisGlobais.usuarioDto.idUsuario}';
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

      _produtoAtivo = true;
      _comissao = produtoModelo.objComissao.produtoTemComissaoEspecial!;
      _vlDaComissao = TextEditingController(text: produtoModelo.objComissao.valorFixoDeComissaoParaEsseProduto.toString());

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

  Future<void> scan() async {
    String barCode = 'XXXXX';
    // try {
    //   barCode = await FlutterBarcodeScanner.scanBarcode(
    //       '#ff6666', 'cancelar', true, ScanMode.BARCODE);
    // } on PlatformException {
    //   barCode = 'falhou';
    // }
    if (!mounted) return;
    setState(() {
      resultadoDoSacanner = barCode;
      _codigoProduto = TextEditingController(text: resultadoDoSacanner);
    });
  }

}

