import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pos_app/controller/operacao-controller.dart';
import 'package:pos_app/dtos/operacao-dto-nova.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';
import 'package:pos_app/utilitarios/tela_inteira.dart';
import 'package:pos_app/utilitarios/texto_ajuda.dart';
import '../app/page/report_pdf.dart';
import '../controller/app_controller.dart';
import '../utilitarios/utils.dart';
import '../utilitarios/widgetsGlobais.dart';

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
  int? _posicaoDaData = 1;
  int? _posicaoDoRecebimento = 1;
  String texto = '';

  DateTime dataFiltroInicio = DateTime.now();
  DateTime dataFiltroFim = DateTime.now();

  String filtroDeDataDeOperacao = 'todos';
  int numeroFiltroDeDataDeOperacao = 2;
  String filtroDeRecebimento = 'todos';
  String resumoDaData='';


  late OperacoesDoBackEnd operacoesBackEnd;

  TextEditingController _searchController = TextEditingController();
  FocusNode _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    getOperacaoList('todos');
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
              getOperacaoList(filtroDeDataDeOperacao);
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
              UtilsWidgets.floatDeAjuda(context,'texto');
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
            getOperacaoList(filtroDeDataDeOperacao);
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
                        controller: _searchController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'digite para buscar',
                          prefixIcon: Icon(Icons.search),
                          suffixIcon:  _searchController.text.length > 0 ? GestureDetector(
                              onTap: () {
                                    setState(() {
                                      _searchController.clear();
                                      operacoesBackEnd.ops = VariaveisGlobais.operacoesBackEnd.ops;
                                      _searchFocusNode.unfocus();
                                    });
                                  },
                                  child: Icon(Icons.clear),
                          ) : null,
                        ),
                        onChanged: (value) {
                          setState(() {
                            var listagem = operacoesBackEnd.ops;
                            operacoesBackEnd.ops = listagem
                                ?.where((produto) => produto.codigoProprioDaOperacao
                                !.toLowerCase()
                                .contains(value.toLowerCase())
                                || produto.objInformacoesDoCadastro!.dataCadastro.toString()
                                .toLowerCase()
                                .contains(value.toLowerCase())
                            )
                                .toList();
                          });
                        },
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 5.0,
                    children: List<Widget>.generate(3,(int index) {
                      List<String> nomes = ['hoje', 'filtrar data','todos'];
                      return ChoiceChip(
                          label:  Text(nomes[index]),
                          selected: _posicaoDaData == index,
                          onSelected: (bool selected) {
                            setState(() {
                              _posicaoDaData = selected ? index : 1;
                              numeroFiltroDeDataDeOperacao = index;
                              if(index==0){
                                filtroDeDataDeOperacao = 'hoje';
                              }else if(index==1){
                                filtroDeDataDeOperacao = 'filtrar';
                              }else{
                                filtroDeDataDeOperacao = 'todos';
                              }
                              getOperacaoList(filtroDeDataDeOperacao);
                            });
                          },
                        );
                      },
                    ).toList(),
                  ),

                  if(numeroFiltroDeDataDeOperacao==1)Text(filtroDeDataDeOperacao),

                  if(numeroFiltroDeDataDeOperacao==1)Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text('data inicio'),
                            GestureDetector(
                              onTap: (){
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white
                                      ),
                                      height: 200,
                                      child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.date,
                                        onDateTimeChanged: (DateTime newDate) {
                                          setState(() {
                                            dataFiltroInicio = newDate;
                                            getOperacaoList('filtrar');
                                          });
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.date_range),
                                  SizedBox(width: 10,),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: AppController.instance.buildThemeData().focusColor,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Text(Utils.exibicaoDeData(dataFiltroInicio),
                                        style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text('ate'),
                            GestureDetector(
                              onTap: (){
                                showCupertinoModalPopup(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white
                                      ),
                                      height: 200,
                                      child: CupertinoDatePicker(
                                        mode: CupertinoDatePickerMode.date,
                                        onDateTimeChanged: (DateTime newDate) {
                                          setState(() {
                                            dataFiltroFim = newDate;
                                            getOperacaoList('filtrar');
                                          });
                                        },
                                      ),
                                    );
                                  },
                                );
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.date_range),
                                  SizedBox(width: 10,),
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: AppController.instance.buildThemeData().focusColor,
                                        borderRadius: BorderRadius.circular(5)
                                    ),
                                    child: Text(Utils.exibicaoDeData(dataFiltroFim),
                                        style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),


                  Wrap(
                    spacing: 5.0,
                    children: List<Widget>.generate(3,(int index) {
                      List<String> nomes = ['recebidas', 'não recebidas','todos'];
                      return ChoiceChip(
                        label:  Text(nomes[index]),
                        selected: _posicaoDoRecebimento == index,
                        onSelected: (bool selected) {
                          setState(() {
                            _posicaoDoRecebimento = selected ? index : 1;
                            if(index==0){
                              filtroDeRecebimento = 'recebidas';
                            }else if(index==1){
                              filtroDeRecebimento = 'naorecebidas';
                            }else{
                              filtroDeRecebimento = 'todos';
                            }
                            // getOperacaoList(filtro);
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
                      operacoesBackEnd.ops![index].vendaList?.forEach((element) {somaVlTotal+=element.vlTotal;
                      DateTime data = DateTime.parse(operacoesBackEnd.ops![index].objInformacoesDoCadastro!.dataCadastro.toString());
                      resumoDaData = " as "+data.hour.toString() +':'+data.minute.toString();

                      });

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
                                    Text('DATA.: ${Utils.converterData(operacoesBackEnd.ops![index].objInformacoesDoCadastro!.dataCadastro.toString())}' +resumoDaData),
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
                        getOperacaoList(filtroDeDataDeOperacao);
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

  Future<void> getOperacaoList(String hoje_filtrar_todos) async {
    setState(() {
      isLoading = true;
    });

    await OperacaoController().atualizarOperacoes();
    operacoesBackEnd = VariaveisGlobais.operacoesBackEnd;
     operacoesBackEnd.ops = VariaveisGlobais.operacoesBackEnd.ops;

    if(hoje_filtrar_todos=='hoje'){
      operacoesBackEnd.ops = operacoesBackEnd.ops?.where((ops) =>
      Utils.converterData(ops.objInformacoesDoCadastro!.dataCadastro.toString()) ==
          Utils.converterData(DateTime.now().toString())).toList();
      print( Utils.converterData(DateTime.now().toString()));
    }if(hoje_filtrar_todos=='filtrar'){
      operacoesBackEnd.ops = operacoesBackEnd.ops
          ?.where((ops) {
        DateTime dataCadastro = DateTime.parse(ops.objInformacoesDoCadastro!.dataCadastro.toString());
        DateTime ontem = DateTime.parse(dataFiltroInicio.toString());
        DateTime amanha = DateTime.parse(dataFiltroFim.toString());
        return dataCadastro.isAfter(ontem) && dataCadastro.isBefore(amanha);
      })
          .toList();
      print(Utils.converterData(DateTime.now().toString()));
    }
    else{
      operacoesBackEnd.ops = VariaveisGlobais.operacoesBackEnd.ops;
    }

    setState(() {
      isLoading = false;
    });
  }
}
