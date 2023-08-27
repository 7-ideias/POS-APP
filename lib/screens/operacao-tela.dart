import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:pos_app/controller/app_controller.dart';
import 'package:pos_app/controller/operacao-controller.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';
import 'package:pos_app/utilitarios/tela_inteira.dart';
import '../utilitarios/utils.dart';

class OperacaoTela extends StatefulWidget {
  const OperacaoTela({Key? key}) : super(key: key);

  @override
  State<OperacaoTela> createState() => _OperacaoTelaState();
}

class _OperacaoTelaState extends State<OperacaoTela> {
  bool existemOperacoes = false;
  bool isLoading = true;
  bool mostrarTudo = true;
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
      VariaveisGlobais.operacoesBackEnd.ops!.isEmpty ? naoTemOperacoes():temOperacoes(context),

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

    return Column(
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
                    title: Text(VariaveisGlobais.operacoesBackEnd.ops![index].codigoProprioDaOperacao.toString()),
                    subtitle: Row(
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
                                Icon(Icons.circle,color: Colors.red,),
                                Text(' NAO RECEBIDO'),
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
    );
  }

  Stack getOperacoesModeloCarrousel(BuildContext context) {
    return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.6, width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: AppController.instance.buildThemeData().dialogBackgroundColor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
            ),
          ),
          Positioned(
              top: 20,
              child: ElevatedButton(onPressed: (){}, child: Text('enviar para o caixa'))),
          Positioned(
            child: SizedBox(
              height: 400,
              child: CarouselSlider(
                options: CarouselOptions(
                  disableCenter: true,
                ),
                items: VariaveisGlobais.operacoesBackEnd.ops
                    ?.map((item) =>
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:
                      Container(
                        height: 300,
                        color: AppController.instance.buildThemeData().primaryColor,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text('1692995990',style: TextStyle(color: Colors.red,fontSize: 30))),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(60.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.objCalculosDeOperacaoDoBackEnd!.vlTotal.toString()),
                                  Text('valor'+Utils.formataParaMoeda(item.objCalculosDeOperacaoDoBackEnd!.vlTotal)),
                                  Text('itens de venda.: X'),
                                  Text('itens de servico.: X'),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                )
                    .toList(),
              ),
            ),
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
