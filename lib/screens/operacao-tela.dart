import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pos_app/controller/operacao-controller.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';
import 'package:pos_app/utilitarios/tela_inteira.dart';

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

  int _selectedIndex = 1;

  // Future<void> _onItemTapped(int index) async {
  //   if(index == 0){
  //
  //   }
  //   if(index == 1){
  //     await Navigator.pushNamed(context, '/operacaoNova');
  //     getOperacaoList();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Center(child: Text('Operações'),)),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: _selectedIndex,
      //   onTap: _onItemTapped,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.search),
      //       label: 'buscar',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.add,size: 30,),
      //       label: 'nova venda/serviço',
      //     ),
      //   ],
      // ),
      body: isLoading == true ?  TelaInteira().widgetDeLoadingPadraoDoApp():
      VariaveisGlobais.operacoesBackEnd.ops == null ? naoTemOperacoes():temOperacoes(context),

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

    );
  }

  Widget naoTemOperacoes() => Center(
    child: Text('nada aqui'),
  );

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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
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
                  ),
                  Wrap(
                    spacing: 20,
                    children: [
                  ChoiceChip(label: Text('teste'), selected: true,),
                  ChoiceChip(label: Text('teste'), selected: false,),
                  ChoiceChip(label: Text('teste'), selected: true,),
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
                      return Slidable(
                        startActionPane: esquerdaDireitaPane(index),
                        child: ListTile(
                          tileColor: !index.isOdd ? Colors.blueGrey : null,
                          leading: CircleAvatar(
                            child: Text((index+1).toString()),
                          ),
                          title: Text('${VariaveisGlobais.operacoesBackEnd.ops![index].codigoProprioDaOperacao}'),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  Text(VariaveisGlobais.moeda+VariaveisGlobais.operacoesBackEnd.ops![index].objCalculosDeOperacaoDoBackEnd!.vlTotal.toString()),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.circle,color: Colors.red,),
                                  Text(VariaveisGlobais.operacoesBackEnd.ops![index].statusQuitada == true? 'ARRUMAR':'ARRUMAR'),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(Icons.circle,color: Colors.blue,),
                                  Text(' NAO RECEBIDO'),
                                ],
                              ),
                            ],
                          ),
                           // tileColor: index.isOdd? Colors.blue : Colors.blueGrey,
                          isThreeLine: true,
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
