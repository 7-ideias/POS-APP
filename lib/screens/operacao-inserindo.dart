import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_app/screens/leitor_de_codigos_de_barras.dart';

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

  int _contador = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Página'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Container(
                      width: 200,
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'não deixe isso vazio';
                          }
                          return null;
                        },
                        style: TextStyle(fontSize: AppController.instance.botaoTamanhoLetras),
                        controller: _codigoProduto,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        decoration: buildInputDecoration('código do item'),
                      ),
                    ),
                    // GestureDetector(
                    //     onTap: (){
                    //       Navigator.push(
                    //         // context,
                    //         // MaterialPageRoute(builder: (context) => Leitor()),
                    //       );
                    //     },
                    //     child: Container(width: 70,height: 70,color: Colors.red,))
                  ],
                ),
                SizedBox(height: 16.0),
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
                Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child:
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'não deixe isso vazio';
                        }
                        return null;
                      },
                      style: TextStyle(fontSize: AppController.instance.botaoTamanhoLetras),
                      // controller: _vlDeVenda,
                      keyboardType:
                      TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'^\d{0,8}(\.\d{0,2})?$')),
                      ],
                      decoration: buildInputDecoration('preço'),
                    ),
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
                  child: WidgetsGlocais.botaoMaster(context, AppController.instance.botaoConfirmar,
                      'inserir'),
                ),
                WidgetsGlocais.botaoMaster(context, AppController.instance.botaoNegar,
                    'cancelar'),
              ],

            ),
          ),
        ],
      ),
    );
  }

  InputDecoration buildInputDecoration(String texto) {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(60)),
      enabledBorder:
      OutlineInputBorder(borderRadius: BorderRadius.circular(60)),
      focusedBorder:
      OutlineInputBorder(borderRadius: BorderRadius.circular(60)),
      labelText: texto,
        prefixText: 'R\$',
    );
  }

  Future<void> retornaOsDadosDaTelaOperacaoInserindo(
      BuildContext context) async {
    // String barCode = await Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => Leitor()),
    // );
    // setState(() {
    //   _codigoProduto = TextEditingController(text: barCode);
    // });
  }
}
