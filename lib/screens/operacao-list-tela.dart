import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pos_app/controller/operacao-controller.dart';
import 'package:pos_app/dtos/operacao-dto-nova.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';
import 'package:pos_app/utilitarios/tela_inteira.dart';
import '../app/page/report_pdf.dart';
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
  int filtro = 1;

  late OperacoesDoBackEnd operacoesBackEnd;

  @override
  void initState() {
    super.initState();
    getOperacaoList(filtro);
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
          if(mostrarTudo == true) FloatingActionButton.extended(
            backgroundColor: Colors.green,
            onPressed: () async {
              await Navigator.pushNamed(context, '/operacaoNova');
              getOperacaoList(filtro);
              mostrarTudo = !mostrarTudo;
            },
            label: Row(
              children: [
                Icon(Icons.add),
                Text('nova venda/serviço' ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          if(mostrarTudo == true) FloatingActionButton.extended(
            backgroundColor: Colors.redAccent,
            onPressed: () async {
              mostrarTudo = !mostrarTudo;
            },
            label: Row(
              children: [
                Icon(Icons.question_mark),
                Text('ajuda' ),
              ],
            ),
          ),
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
          SizedBox(
            height: 10,
          ),
          if(mostrarTudo == false)FloatingActionButton(onPressed: (){
            getOperacaoList(filtro);
          },child: Icon(Icons.refresh),)
        ],
      ),
      body: isLoading == true ?  TelaInteira().widgetDeLoadingPadraoDoApp():
      operacoesBackEnd.ops == null ? naoTemOperacoes():temOperacoes(context),
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
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.95,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('OPERAÇÕES: ${operacoesBackEnd.ops?.length.toString()}'),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'digite para buscar',
                          prefixIcon: Icon(Icons.search),
                          suffixIcon: GestureDetector(
                              onTap: (){
                                //FIXME
                              },
                              child: Icon(Icons.clear)),
                        ),
                        onChanged: (value) {
                          setState(() {
                            // var listagem = produtoDtoList.produtosList;
                            // produtoList = listagem
                            //     .where((produto) => produto.nomeProduto
                            //     .toLowerCase()
                            //     .contains(value.toLowerCase()) || produto.codigoDeBarras
                            //     .toLowerCase()
                            //     .contains(value.toLowerCase()))
                            //     .toList();
                          });
                        },
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 5.0,
                    children: List<Widget>.generate(2,(int index) {
                      List<String> nomes = ['hoje', 'todos'];
                      return ChoiceChip(
                          label:  Text(nomes[index]),
                          selected: _value == index,
                          onSelected: (bool selected) {
                            setState(() {
                              _value = selected ? index : 1;
                              filtro = index;
                              getOperacaoList(filtro);
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
                    itemCount: operacoesBackEnd.ops?.length,
                    itemBuilder: (context, index) {

                      double somaVlTotal = 0.00;
                      operacoesBackEnd.ops![index].vendaList?.forEach((element) {somaVlTotal+=element.vlTotal;});

                      return Slidable(
                        startActionPane: esquerdaDireitaPane(index),
                        endActionPane: direitaEsquerdaPane(index),
                        child: Card(
                          // elevation: 5,
                          child: ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('OPERACAO - ${operacoesBackEnd.ops![index].codigoProprioDaOperacao}'),
                              ],
                            ),
                            subtitle: Column(
                              children: [
                                Row(
                                  children: [
                                    Text('DATA.: ${Utils.converterData(operacoesBackEnd.ops![index].objInformacoesDoCadastro!.dataCadastro.toString())}'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(Utils.formataParaMoeda(somaVlTotal)),
                                  ],
                                ),
                                Divider(),
                                operacoesBackEnd.ops![index].statusQuitada == true ?
                                Row(
                                  children: [
                                    Icon(Icons.circle,color: Colors.green,),
                                    Text(' RECEBIDA'),
                                  ],
                                ):
                                Row(
                                  children: [
                                    Icon(Icons.circle,color: Colors.redAccent,),
                                    Text(' NAO RECEBIDA'),
                                  ],
                                ),
                              ],
                            ),
                             // tileColor: index.isOdd? Colors.blue : Colors.blueGrey,
                            isThreeLine: true,
                          ),
                        ),
                      );
                      // return ListTile(title: Text(operacoesBackEnd.ops![index].id.toString()));
                    }),
              ),
              SizedBox(height: 100,)
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
          backgroundColor: Colors.blueAccent,
          icon: Icons.remove_red_eye_outlined,
          label: 'detalhes',
          onPressed:  (context) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('compartilhar?'),
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
                        Ops? operacao = operacoesBackEnd.ops?[index];
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
        SlidableAction(
          backgroundColor: Colors.green,
          icon: Icons.monetization_on,
          label: 'receber',
          onPressed:  (context) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('receber?'),
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
                        // Ops? operacao = operacoesBackEnd.ops?[index];
                        Navigator.of(context).pop();
                        // reportView(context, index, operacao);
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
          label: 'apagar',
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
                        await OperacaoController().excluirOperacaoPorID(operacoesBackEnd.ops![index].id.toString());
                        getOperacaoList(filtro);
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

  Future<void> getOperacaoList(int filtro) async {
    setState(() {
      isLoading = true;
    });

    await OperacaoController().atualizarOperacoes();
    operacoesBackEnd = VariaveisGlobais.operacoesBackEnd;
     operacoesBackEnd.ops = VariaveisGlobais.operacoesBackEnd.ops;

    if(filtro==0){
      operacoesBackEnd.ops = operacoesBackEnd.ops?.where((ops) =>
      Utils.converterData(ops.objInformacoesDoCadastro!.dataCadastro.toString()) ==
          Utils.converterData(DateTime.now().toString())).toList();
      print( Utils.converterData(DateTime.now().toString()));
    }else{
      operacoesBackEnd.ops = VariaveisGlobais.operacoesBackEnd.ops;
    }

    setState(() {
      isLoading = false;
    });
  }
}
