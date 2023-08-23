import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:pos_app/controller/operacao-controller.dart';
import 'package:pos_app/dtos/operacao-dto-list.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';

import '../controller/app_controller.dart';
import '../dtos/objetos/obj-venda-e-servico.dart';
import '../dtos/operacao-dto.dart';
import 'operacao-inserindo.dart';

/**
 * TODO CARREGAR AS INFORMACOES DO BACKEND COM OPERACOES NAO FINALIZADAS
 * UMA OPERACAO FINALIZADA MANDA A OPERACAO PARA O CAIXA
 * SEM ESTAR FINALIZADA A OPERACAO NAO FICA PRONTA PARA RECEBER - ISSO GARANTE
 *    QUE O CAIXA NAO RECEBA ENQUANTO AINDA O VENDEDOR ESTIVER LANCANDO VENDAS
 * TODO FAZER LOGICA PARA APARECER O WIDGET CORRETO DEPENDENDO SE EXISTEM OU NAO OPERACOES
 */

/*

modelo de response sa api
{
  "quantidadeDeOperacoesNaoFinalizadas" : "1",
  "valor de vendas" : "5230.00"
  "operacoes" : [
      {
        "id" "HASH DA ID",
        "codigoProprio" "1000000001",
        "tipo" : "VENDA",
        "valor" : "1000.00"
      }
  ]
}

 */

class OperacaoTela extends StatefulWidget {
  const OperacaoTela({Key? key}) : super(key: key);

  @override
  State<OperacaoTela> createState() => _OperacaoTelaState();
}

class _OperacaoTelaState extends State<OperacaoTela> {
  bool existemOperacoes = false;
  bool isLoading = true;
  List<OperacaoDto> operacaoList = [];
  late OperacaoDtoList operacaoDtoList;
  double soma = 0.00;
  int qtOperacoes = 0;

  double somaValorTotal = 0.00;

  //conjunto da barra inferior
  int _page = 1;
  final GlobalKey _bottomNavigationKey = GlobalKey();

  //contrucao do objeto
  List<ObjVendaEServico> objVendaEServicoList = [];

  String texto = '';

  @override
  void initState() {
    super.initState();
    getOperacaoList();
    _page = 2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppController.instance.corTelaFundo,
      appBar: _page == 1
          ? null
          : AppBar(
              title: Center(
                  child: Text(
              'Operações',
              textAlign: TextAlign.center,
            ))),
      // floatingActionButton: Column(
      //   crossAxisAlignment: CrossAxisAlignment.end,
      //   mainAxisAlignment: MainAxisAlignment.end,
      //   children: [
      //     FloatingActionButton.extended(
      //       onPressed: () {
      //         Navigator.pushReplacementNamed(context, '/operacaoNova');
      //       },
      //       label: Text('nova operacao'),
      //       icon: Icon(Icons.add),
      //       shape: RoundedRectangleBorder(
      //         borderRadius: BorderRadius.all(Radius.circular(10)),
      //       ),
      //     ),
      //     SizedBox(
      //       height: 20,
      //     ),
      //     FloatingActionButton(
      //         child: Icon(Icons.cancel),
      //         onPressed: () {
      //           Navigator.pop(context);
      //         }),
      //   ],
      // ),
      bottomNavigationBar: _page == 1 ? null : buildCurvedNavigationBar(),
      body: body(),

      // isLoading == false ? (existemOperacoes == false
      //   ? widgetExitemOperacoes()
      //   : widgetZeroOperacoes()): Center(child: TelaInteira().widgetDeLoadingPadraoDoApp()),
    );
  }

  Widget body() {
    return _page == 0
        ? pesquisa()
        : _page == 1
            ? nova()
            : operacoes();
  }

  Widget nova() {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: AppController.instance.corTelaFundo,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Card(
            elevation: 10,
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width * 0.95,
              decoration: BoxDecoration(
                color: AppController.instance.corTelaAcima,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('itens.: ' + objVendaEServicoList.length.toString(),style: TextStyle(fontSize: AppController.instance.botaoTamanhoLetras,color: AppController.instance.corLetras),)
                    ],
                  ),
                  Row(
                    children: [
                      Text('valor.: ' + somaValorTotal.toString(),style: TextStyle(fontSize: AppController.instance.botaoTamanhoLetras,color: AppController.instance.corLetras))
                    ],
                  ),
                ],
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
                    title: Text(
                        'ooi ' ),
                  ),
                ),
              );
            },
          )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () {
          retornaOsDadosDaTelaOperacaoInserindo(context);
        },
        child: Icon(
          Icons.add,
          color: AppController.instance.corTelaFundo,
          size: 30,
        ),
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
    });
  }

  Widget operacoes() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            Card(
              elevation: 10,
              child: Container(
                color: Colors.pink,
                height: 200,
                width: MediaQuery.of(context).size.width * 0.9,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget pesquisa() {
    return Container();
  }

  Widget buildCurvedNavigationBar() {
    return CurvedNavigationBar(
      index: 1,
      backgroundColor: AppController.instance.corTelaFundo,
      key: _bottomNavigationKey,
      items: <Widget>[
        SizedBox(
          height: 60,
          width: 60,
          child: Icon(
            Icons.search,
            size: 50,
          ),
        ),
        SizedBox(
          height: 60,
          width: 60,
          child: Icon(
            Icons.add,
            size: 50,
          ),
        ),
        SizedBox(
          height: 60,
          width: 60,
          child: Lottie.asset('assets/seller.json', fit: BoxFit.contain),
        ),
      ],
      onTap: (index) {
        setState(() {
          _page = index;
        });
      },
    );
  }

  ActionPane direitaEsquertaPane(int index) {
    return ActionPane(
      motion: const StretchMotion(),
      children: [
        SlidableAction(
          backgroundColor: Colors.red,
          icon: Icons.arrow_downward_outlined,
          onPressed: (context) {
            // operacaoList.remove(index);
            // setState(() {
            //
            // });
          },
        ),
      ],
    );
  }

  Widget retornaALista(int index) {
    return ListTile(
      title: Text(
        operacaoList[index].tipoDeOperacaoEnum,
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
      subtitle: Row(
        children: [
          Text(
            VariaveisGlobais.moeda +
                operacaoList[index]
                    .objCalculosDeOperacaoDoBackEnd!
                    .vlTotal
                    .toString(),
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
      shape: Border.all(color: Colors.white),
      onTap: () {},
    );
  }

  Widget widgetZeroOperacoes() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          color: Colors.blue,
          height: 200,
          width: MediaQuery.of(context).size.width * .95,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'não existem operações não finalizadas',
                    style: TextStyle(fontSize: 22, color: Colors.white),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  Future<void> getOperacaoList() async {
    setState(() {
      isLoading = true;
    });
    http.Response fazRequisicao = await OperacaoController().fazRequisicao();
    if (fazRequisicao.statusCode == 200) {
      debugPrint(
          'fazRequisicao.statusCode -> ' + fazRequisicao.statusCode.toString());
      var buscarProdutoList =
          OperacaoController().buscarOperacaoList(fazRequisicao);
      buscarProdutoList.then((listaProdutos) {
        operacaoList = listaProdutos.produtosList;

        qtOperacoes = 0;
        qtOperacoes = operacaoList.length;

        soma = 0.00;
        soma = operacaoList.fold(
            soma,
            (accumulated, element) =>
                accumulated + element.objCalculosDeOperacaoDoBackEnd.vlTotal);

        setState(() {
          operacaoDtoList = listaProdutos;
          isLoading = false;
          debugPrint('sucesso!!!');
        });
      }).catchError((erro) {
        print(erro);
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }
}
