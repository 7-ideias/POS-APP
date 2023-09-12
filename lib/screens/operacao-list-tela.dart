import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pos_app/controller/operacao-controller.dart';
import 'package:pos_app/dtos/operacao-dto-nova.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';
import 'package:pos_app/utilitarios/tela_inteira.dart';

import '../app/page/report_pdf.dart';
import '../dtos/objetos/obj-venda-e-servico.dart';
import '../utilitarios/utils.dart';

class OperacaoTela extends StatefulWidget {
  const OperacaoTela({Key? key}) : super(key: key);

  @override
  State<OperacaoTela> createState() => _OperacaoTelaState();
}

class _OperacaoTelaState extends State<OperacaoTela> {
  bool existemOperacoes = false;
  bool isLoading = true;
  bool mostrarTudo = false;
  double soma = 0.00;
  int qtOperacoes = 0;
  int? _value = 1;
  String texto = '';

  @override
  void initState() {
    super.initState();
    getOperacaoList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Operações'),)),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 10,
          ),
          mostrarTudo == true ?FloatingActionButton.extended(
            backgroundColor: Colors.green,
            onPressed: () async {
              await Navigator.pushNamed(context, '/operacaoNova');
              getOperacaoList();
              mostrarTudo = !mostrarTudo;
            },
            label: Row(
              children: [
                Icon(Icons.add),
                Text('nova venda/serviço' ),
              ],
            ),
          ):Container(),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                mostrarTudo = !mostrarTudo;
              });
            },
            label: mostrarTudo == false ? Row(
              children: [
                Icon(Icons.add),
                Text(' mais ações' ),
              ],
            ) : Row(
              children: [
                Icon(Icons.hide_source),
                Text(' esconder ações' ),
              ],
            ),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          // FloatingActionButton(onPressed: (){},child: Icon(Icons.refresh),)
        ],
      ),
      body: isLoading == true ?  TelaInteira().widgetDeLoadingPadraoDoApp():
      VariaveisGlobais.operacoesBackEnd.ops == null ? naoTemOperacoes():temOperacoes(context),
    );
  }

  Widget naoTemOperacoes() {
    return Center (
    child: Text('não existem operações no sistema'),
  );
  }

  Widget temOperacoes(BuildContext context) {

    return AnimatedOpacity(
      opacity: mostrarTudo == true ? 0.2 : 1,
      duration: Duration(seconds: 1),
      child: Stack(
        children: [
          Column(
            children: [
              //card superior
              Column(
                children: [
                  Card(
                    elevation: 10,
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text('quantidade de operacoes abertas:${VariaveisGlobais.operacoesBackEnd.quantidadeDeOps}',
                               ),
                          ),
                          Text('quantidade de operacoes abertas:${VariaveisGlobais.operacoesBackEnd.ops?.length.toString()}',
                             ),
                        ],
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 20,
                    children: [
                      ChoiceChip(label: Text('hoje'), selected: true,onSelected: (bool selected) {
                        setState(() {
                          print('selecionado');
                        });
                      },),
                      ChoiceChip(label: Text('ultimos 7 dias'), selected: false,),
                      ChoiceChip(label: Text('ultimo mes'), selected: true,),
                    ],
                  ),
                  Wrap(
                    spacing: 5.0,
                    children: List<Widget>.generate(4,(int index) {
                        return ChoiceChip(
                          label: Text('Item $index'),
                          selected: _value == index,
                          onSelected: (bool selected) {
                            setState(() {
                              _value = selected ? index : null;
                            });
                          },
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),

              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: VariaveisGlobais.operacoesBackEnd.ops?.length,
                    itemBuilder: (context, index) {

                      double somaVlTotal = 0.00;
                      VariaveisGlobais.operacoesBackEnd.ops![index].vendaList?.forEach((element) {somaVlTotal+=element.vlTotal;});

                      return Slidable(
                        startActionPane: esquerdaDireitaPane(index),
                        endActionPane: direitaEsquerdaPane(index),
                        child: Card(
                          elevation: 5,
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('OPERACAO - ${VariaveisGlobais.operacoesBackEnd.ops![index].codigoProprioDaOperacao}'),
                              ],
                            ),
                            subtitle: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(Utils.formataParaMoeda(somaVlTotal)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.circle,color: Colors.redAccent,),
                                    Text(' NAO RECEBIDO'),
                                  ],
                                ),
                              ],
                            ),
                             // tileColor: index.isOdd? Colors.blue : Colors.blueGrey,
                            isThreeLine: true,
                          ),
                        ),
                      );
                      // return ListTile(title: Text(VariaveisGlobais.operacoesBackEnd.ops![index].id.toString()));
                    }),
              )
            ],
          ),
          if(mostrarTudo == true)GestureDetector(
            onTap: (){
              setState(() {
                mostrarTudo = false;
              });
            },
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }

  ActionPane direitaEsquerdaPane(int index) {
    return ActionPane(
      motion: const StretchMotion(),
      children: [
        SlidableAction(
          backgroundColor: Colors.blue,
          icon: Icons.print,
          onPressed:  (context) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Imprimir?'),
                  // content: Text('quer realmente apagar?'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Cancelar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Confirmar'),
                      onPressed: () {
                        Ops? operacao = VariaveisGlobais.operacoesBackEnd.ops?[index];
                        Navigator.of(context).pop();
                        reportView(context, index, operacao);
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),

      ],

    );
  }


  ActionPane esquerdaDireitaPane(int index) {
    return ActionPane(
      motion: const StretchMotion(),
      children: [
        SlidableAction(
          backgroundColor: Colors.red,
          icon: Icons.clear,
          onPressed:  (context) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Confirmação'),
                  content: Text('quer realmente apagar?'),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Cancelar'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    TextButton(
                      child: Text('Confirmar'),
                      onPressed: () async {
                        Navigator.of(context).pop();
                        await OperacaoController().excluirOperacaoPorID(VariaveisGlobais.operacoesBackEnd.ops![index].id.toString());
                        getOperacaoList();
                        },
                    ),
                  ],
                );
              },
            );
          },
        ),

      ],

    );
  }


  Future<void> getOperacaoList() async {
    setState(() {
      isLoading = true;
    });
     await OperacaoController().atualizarOperacoes();
    setState(() {
      isLoading = false;
    });
  }


}
