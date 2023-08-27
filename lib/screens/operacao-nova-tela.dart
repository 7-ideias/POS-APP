import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/dtos/objetos/obj-agenda.dart';
import 'package:pos_app/dtos/objetos/obj-calculos-de-operacao-do-back-end.dart';
import 'package:pos_app/dtos/objetos/obj-servico.dart';
import 'package:pos_app/utilitarios/utils.dart';
import '../controller/app_controller.dart';
import '../controller/produto-controller.dart';
import '../dtos/objetos/obj-venda-e-servico.dart';
import '../dtos/operacao-dto.dart';
import '../utilitarios/VariaveisGlobais.dart';
import '../utilitarios/tela_inteira.dart';
import 'operacao-inserindo.dart';

class OperacaoNova extends StatefulWidget {
  const OperacaoNova({Key? key}) : super(key: key);
  @override
  State<OperacaoNova> createState() => _OperacaoNovaState();
}

class _OperacaoNovaState extends State<OperacaoNova> {

  //contrucao do objeto
  List<ObjVendaEServico> objVendaEServicoList = [];

  double somaValorTotal = 0.00;

  bool _isLoading = false;
  bool confirmacaoDeSucessoNaAPI = false;

bool carregando = true;

  @override
  Widget build(BuildContext context) {
    return _isLoading == true ?
    (_isLoading == true && confirmacaoDeSucessoNaAPI == true ? TelaInteira().sucesso():
    TelaInteira().widgetDeLoadingPadraoDoApp()):Scaffold(
      appBar: AppBar(),
      body: objVendaEServicoList.length > 0 ?Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //card
          Card(
            elevation: 10,
            child: Container(
              height: MediaQuery.of(context).size.height * .3,
              width: MediaQuery.of(context).size.width * 0.95,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        Text('cliente nao informado',style: TextStyle(fontSize: AppController.instance.botaoTamanhoLetras )),
                      ],
                    ),
                    Row(
                      children: [
                        Text('itens.: ' + objVendaEServicoList.length.toString(),style: TextStyle(fontSize: AppController.instance.botaoTamanhoLetras ),)
                      ],
                    ),
                    Row(
                      children: [
                        Text('valor.: ' + Utils.formataParaMoeda(somaValorTotal),style: TextStyle(fontSize: AppController.instance.botaoTamanhoLetras ))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
                itemCount: objVendaEServicoList.length,
                itemBuilder: (context, index) {
                  return Slidable(
                    endActionPane: direitaEsquertaPane(index),
                    child: Card(
                      elevation: 10,
                      child: ListTile(
                        title: Text(objVendaEServicoList[index].descricaoProduto.toString(), ),
                        subtitle: Text(objVendaEServicoList[index].vlTotal.toString()),
                      ),
                    ),
                  );
                },
              )),
        ],
      ):Container(child: Center(child: Text('nada ainda'),),),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          //send para a api
          objVendaEServicoList.length > 0 ?FloatingActionButton(
            onPressed: () {
              sendApiNovaOperacao();
            },
            child: Icon(
              Icons.save,
              size: 30,
            ),
          ) : Container(),
          SizedBox(height: 20,),
          //adicionar novo
          FloatingActionButton(
            onPressed: () {
              atualizarProdutos();
              retornaOsDadosDaTelaOperacaoInserindo(context);
            },
            child: Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> retornaOsDadosDaTelaOperacaoInserindo(
      BuildContext context) async {
    ObjVendaEServico objVendaEServico = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InserindoProduto()),
    );
    setState(() {
      objVendaEServicoList.add(objVendaEServico);
      recalculaValoresParaCard();
    });
  }

  ActionPane direitaEsquertaPane(int index) {
    return ActionPane(
      motion: const StretchMotion(),
      children: [
        SlidableAction(
          backgroundColor: Colors.red,
          icon: Icons.clear,
          onPressed: (context) {
            objVendaEServicoList.removeAt(index);
            setState(() {
              recalculaValoresParaCard();
            });
          },
        ),
      ],
    );
  }

  Future<void> sendApiNovaOperacao() async {
    setState(() {
      _isLoading = true;
    });
    var url = '${VariaveisGlobais.endPoint}/operacao/inserir';
    String idColaborador = '${VariaveisGlobais.usuarioDto.id}';

    var body;

    // double valorCusto = 0.00;
    // valorCusto = widget.produtoList[0].objCalculosDeProdutoDoBackEnd.ultimoVlEmGranaPagoPeloProduto;

    var json = OperacaoDto(
        id: "id",
        idUsuario: "idUsuario",
        codigoProprioDaOperacao: "codigoProprioDaOperacao",
        descricao: "DESCRICAO",
        objCalculosDeOperacaoDoBackEnd: ObjCalculosDeOperacaoDoBackEnd(vlTotal: 10.00,operacaoTotalmenteRecebida: false),
        objInformacoesDoCadastro: null,
        operacaoFinalizadaEProntaParaOCaixa: false,
        statusQuitada: false,
        tipoDeOperacaoEnum: "VENDA",
        objAgenda: ObjAgenda(
            eventoUnico:false,
            tipoDeRecorrencia:"",
            dataDaUltimaOcorrencia:"",
            dataDeVencimentoParaEventoFuturo:""),
        objLogsList: null,
        vendaList: objVendaEServicoList,
        servicoList: null,
        objRecebimentosList: null,
    ).toJson();

    var bodyTeste = jsonEncode(json);

    body = jsonEncode({
      "idCliente": "NAO INFORMADO",
      "codigoProprioDaOperacao": "xpto",
      "descricao": "xpto",
      "tipoDeOperacaoEnum": "VENDA",
      "statusQuitada": false,
      "operacaoFinalizadaEProntaParaOCaixa": false,
      "objAgenda": {
        "eventoUnico": false,
        "tipoDeRecorrencia": null
      },
      "vendaList": [
        {
          "idCodigoProduto": "e098ab9b06aa48149a0f34ca5c95d4cc",
          "codigoDeBarras": "ISSO EH SEMPRE CALCULADO DEPOIS PELO BACKEND",
          "descricaoProduto": "ISSO EH SEMPRE CALCULADO DEPOIS PELO BACKEND",
          "qt": 10.55,
          "vlUnitario": "15.22",
          "vlTotal": "150.22",
          "idColaboradorResponsavelPeloServico": "ssssssssssss",
          "nomeColaboradorResponsavel": "ssssssssssss"
        }
      ],
      "servicoList": [
        {
          "idCodigoProduto": "e098ab9b06aa48149a0f34ca5c95d4cc",
          "codigoDeBarras": "ISSO EH SEMPRE CALCULADO DEPOIS PELO BACKEND",
          "descricaoProduto": "ISSO EH SEMPRE CALCULADO DEPOIS PELO BACKEND",
          "qt": 10.55,
          "vlUnitario": "15.22",
          "vlTotal": "150.22",
          "idColaboradorResponsavelPeloServico": "ssssssssssss",
          "nomeColaboradorResponsavel": "ssssssssssss"
        }
      ],
      "objRecebimentosList": [
        {
          "data": null,
          "idDeQuemRegistrou": "idDeQuemRegistrou",
          "objGrana": {
            "tipo1": 10.55,
            "tipo2": 10.55,
            "tipo3": 10.55,
            "tipo4": 10.55,
            "tipo5": 10.55
          }
        }
      ],
      "objLogsList": [
        {
          "objInformacoesDoCadastro": {
            "idDeQuemCadastrou": "idDeQuemCadastrou",
            "dataCadastro": null
          },
          "ocorrencia": "ocorrencia"
        }
      ]
    });
    var headers = {
      'Content-Type': 'application/json',
      'idUsuario': '${VariaveisGlobais.usuarioDto.id}',
      'idColaborador': idColaborador
    };

    var response = await http.post(Uri.parse(url), headers: headers, body: bodyTeste);
    // var response = await http.post(Uri.parse(url), headers: headers, body: body);
    debugPrint(response.statusCode.toString());


    if(response.statusCode == 201){
      setState(() {
        confirmacaoDeSucessoNaAPI = true;
      });
    }
      await Future.delayed(Duration(seconds: 2));

    confirmacaoDeSucessoNaAPI = false;

    setState(() {
        _isLoading = true;
    });
    Navigator.of(context).pop();

  }

  void recalculaValoresParaCard() {
    somaValorTotal = 0.00;
    objVendaEServicoList.forEach((element) {
      somaValorTotal = somaValorTotal + double.parse(element.vlTotal.toString());
    });
  }


  Future<void> atualizarProdutos()async {
    print('atualizarProdutos');
    await ProdutoController().atualizarListaDeProdutos();
    setState(() {
      carregando = false;
    });
  }


}