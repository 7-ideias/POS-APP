import 'package:flutter/material.dart';

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
        Container(
          color: Colors.blue,
          height: 10,
          width: 10,
        ),
      ],
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
}
