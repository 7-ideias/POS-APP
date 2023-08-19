import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/controller/operacao-controller.dart';
import 'package:pos_app/dtos/operacao-dto-list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../dtos/operacao-dto.dart';

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

  @override
  void initState() {
    super.initState();
    getOperacaoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
              child: Text(
        'Operações',
        textAlign: TextAlign.center,
      ))),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/operacaoNova');
            },
            label: Text('nova operacao'),
            icon: Icon(Icons.add),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton(
              child: Icon(Icons.cancel),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
      body: existemOperacoes == false
          ? widgetExitemOperacoes()
          : widgetZeroOperacoes(),
    );
  }

  Widget widgetExitemOperacoes() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(20)),
              height: 200,
              width: MediaQuery.of(context).size.width * .95,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'existem operações não finalizadas',
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                        Text(
                          'blalblaa',
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                        Text(
                          'xxxxxxxxx',
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 20,),
        Expanded(
          child: isLoading
              ? Center(
            child: CircularProgressIndicator(),
          )
              : RefreshIndicator(
            onRefresh: () => getOperacaoList(),
            child:  ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: operacaoList.length,
              itemBuilder: (context, index) {
                return Slidable(
                    startActionPane: esquerdaDireitaPane(),
                    endActionPane: direitaEsquertaPane(),
                    child: retornaALista(index));
              },
            ) ,
          ),
        ),
      ],
    );
  }

  ActionPane esquerdaDireitaPane() {
    return ActionPane(
      motion: const StretchMotion(),
      children: [
        SlidableAction(
          backgroundColor: Colors.blueAccent,
          icon: Icons.share,
          onPressed:  (context) {

          },
        ),
        SlidableAction(
          label: 'pdf',
          backgroundColor: Colors.purpleAccent,
          icon: Icons.picture_as_pdf,
          onPressed:  (context) {

          },
        ),

      ],

    );
  }
  ActionPane direitaEsquertaPane() {
    return ActionPane(
                    motion: const StretchMotion(),
                    children: [
                      SlidableAction(
                        label: 'caixa',
                        backgroundColor: Colors.indigoAccent,
                        icon: Icons.monetization_on,
                        onPressed:  (context) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Enviar a venda para o caixa?'),
                                content: Text('isso deixa a venda pronta para ser recebida'),
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
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      ),
                      SlidableAction(
                        label: 'editar',
                        backgroundColor: Colors.amber,
                        icon: Icons.edit,
                        onPressed:  (context) {

                        },
                      ),

                    ],

                  );
  }

  Widget retornaALista(int index) {
    return ListTile(
      title: Text(operacaoList[index].tipoDeOperacaoEnum),
      subtitle: Row(
        children: [
          Text(operacaoList[index].objCalculosDeOperacaoDoBackEnd!.vlTotal.toString())
        ],
      ),
      shape: Border.all(color: Colors.black12),
      onTap: () {
      },
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
    if (fazRequisicao.statusCode == 200){
      debugPrint('fazRequisicao.statusCode -> '+fazRequisicao.statusCode.toString());
      var buscarProdutoList = OperacaoController().buscarOperacaoList(fazRequisicao);
      buscarProdutoList.then((listaProdutos) {
        operacaoList = listaProdutos.produtosList;
        setState(() {
          operacaoDtoList = listaProdutos;
          isLoading = false;
          debugPrint('sucesso!!!');
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
