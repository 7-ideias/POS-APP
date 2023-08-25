import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/controller/app_controller.dart';
import 'package:pos_app/controller/operacao-controller.dart';
import 'package:pos_app/dtos/operacao-dto-list.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';
import '../dtos/operacao-dto.dart';
import '../utilitarios/utils.dart';

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

  String texto = '';

  @override
  void initState() {
    super.initState();
    getOperacaoList();
  }

  int _selectedIndex = 1;


  Future<void> _onItemTapped(int index) async {
    if(index == 0){

    }
    if(index == 1){
      Navigator.pushNamed(context, '/operacaoNova');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add,size: 30,),
            label: 'nova operacao',
          ),
        ],
      ),
      // bottomNavigationBar: buildCurvedNavigationBar(),
      body: operacoes(),
    );
  }

  Widget operacoes() {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('operacoes')),
      ),
        body: Column(
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
                          style: TextStyle(fontSize: AppController.instance.botaoTamanhoLetras),),
                      ),
                      Text('quantidade de operacoes abertas:${VariaveisGlobais.operacoesBackEnd.ops?.length.toString()}',
                        style: TextStyle(fontSize: AppController.instance.botaoTamanhoLetras),),

                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            Stack(
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
            ),



            // ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     shrinkWrap: true,
            //     itemCount: VariaveisGlobais.operacoesBackEnd.ops?.length,
            //     itemBuilder: (context, index) {
            //       return Card(
            //         child: Text(VariaveisGlobais.operacoesBackEnd.ops![index].id.toString()),
            //       );
            //       // return ListTile(title: Text(VariaveisGlobais.operacoesBackEnd.ops![index].id.toString()));
            //     })
          ],
        ),
    );
  }

  Widget pesquisa() {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Center(child: Text('pesquisa')),
      ),
      body: Container(),
    );
  }

  // Widget retornaALista(int index) {
  //   return ListTile(
  //     title: Text(
  //       operacaoList[index].tipoDeOperacaoEnum,
  //       style: TextStyle(fontSize: 18, color: Colors.white),
  //     ),
  //     subtitle: Row(
  //       children: [
  //         Text(
  //           VariaveisGlobais.moeda +
  //               operacaoList[index]
  //                   .objCalculosDeOperacaoDoBackEnd.vlTotal
  //                   .toString(),
  //         )
  //       ]
  //     ),
  //     onTap: () {}
  //   );
  // }

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
     await OperacaoController().atualizarOperacoes();
    setState(() {
      isLoading = false;
    });
  }
}
