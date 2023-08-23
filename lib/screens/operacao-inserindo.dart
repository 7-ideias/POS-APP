import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_app/screens/leitor_de_codigos_de_barras.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';

import '../controller/app_controller.dart';
import '../dtos/objetos/obj-venda-e-servico.dart';
import '../utilitarios/widgetsGlobais.dart';

class InserindoProduto extends StatefulWidget {
  InserindoProduto({Key? key}) : super(key: key);

  @override
  State<InserindoProduto> createState() => _InserindoProdutoState();
}

class _InserindoProdutoState extends State<InserindoProduto> {
  ObjVendaEServico objVendaEServico = ObjVendaEServico(
    id: '',
    idCodigoProduto: '',
    codigoDeBarras: '',
    descricaoProduto: '',
    qt: 1,
    vlUnitario: 0.00,
    vlTotal: 0.00,
    idColaboradorResponsavelPeloServico: '',
    nomeColaboradorResponsavel: '',
  );

  TextEditingController _codigoProduto = TextEditingController();
  TextEditingController _precoProduto = TextEditingController();

  int _contador = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                //codigo de barras
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      height: 50,
                      width: 200,
                      child: UtilsWidgets.textFormField(true,18,'não deixe isso vazio', _codigoProduto, TextInputType.number, 'código do item',''),
                    ),
                    GestureDetector(
                        onTap: (){
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => Leitor()),
                          // );
                        },
                        child: Container(width: 70,height: 70,
                          child: Icon(Icons.search,size: 50,),)),
                    GestureDetector(
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Leitor()),
                          );
                        },
                        child: Container(width: 70,height: 70,
                        child: Icon(Icons.qr_code_2,size: 50,),))
                  ],
                ),
                SizedBox(height: 16.0),
                UtilsWidgets.textFormField(false,18,'não deixe isso vazio', _codigoProduto, TextInputType.number, 'descrição',''),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            _contador <= 1 ? _contador : _contador--;
                            print(_contador);
                          });
                        },
                        child: CircleAvatar(
                          maxRadius: 50,
                          child: Text('-',style: TextStyle(fontSize: 30)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 100,
                        color: Colors.white,
                        child: Center(
                          child: Text(_contador.toString(),style: TextStyle(fontSize: 30)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            _contador++;
                            print(_contador);
                          });
                        },
                        child: CircleAvatar(
                          maxRadius: 50,
                          child: Text('+',style: TextStyle(fontSize: 30)),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                //preco
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child : UtilsWidgets.textFormField(true,18,'não deixe isso vazio', _precoProduto,
                        TextInputType.numberWithOptions(decimal: true), 'preço',VariaveisGlobais.moeda),
                  ),
                ),
                SizedBox(height: 16.0),
                GestureDetector(
                  onTap: (){
                    objVendaEServico = ObjVendaEServico(
                        id: _codigoProduto.text,
                        vlTotal: 10.00
                    );
                    Navigator.pop(context, objVendaEServico);
                  },
                  child: UtilsWidgets.botaoMaster(context, AppController.instance.botaoConfirmar,
                      'inserir'),
                ),
                UtilsWidgets.botaoMaster(context, AppController.instance.botaoNegar,
                    'cancelar'),
              ],

            ),
          ),
        ],
      ),
    );
  }



  Future<void> retornaOsDadosDaTelaOperacaoInserindo(
      BuildContext context) async {
    String barCode = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Leitor()),
    );
    setState(() {
      _codigoProduto = TextEditingController(text: barCode);
    });
  }
}
