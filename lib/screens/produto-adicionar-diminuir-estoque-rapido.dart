import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_app/controller/app_controller.dart';

import '../dtos/produto-dto.dart';
import '../utilitarios/widgetsGlobais.dart';

class ProdutoEstoqueRapidoTela extends StatefulWidget {
  List<ProdutoDto> produtoList = [];
  String adicionarOuBaixar;

  ProdutoEstoqueRapidoTela({Key? key, required this.produtoList, required this.adicionarOuBaixar})
      : super(key: key);


  @override
  State<ProdutoEstoqueRapidoTela> createState() =>
      _ProdutoEstoqueRapidoTelaState();
}

class _ProdutoEstoqueRapidoTelaState extends State<ProdutoEstoqueRapidoTela> {
  int _contador = 1;
  TextEditingController numeroController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppController.instance.corTelaFundo,
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.adicionarOuBaixar == 'adicionar' ? 'ADICIONAR' : 'BAIXAR',
                  style: TextStyle(
                      fontSize: 30, color: AppController.instance.corLetras),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'codigo.: ${widget.produtoList[0].codigoDeBarras}',
                  style: TextStyle(
                      fontSize: 20, color: AppController.instance.corLetras),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.produtoList[0].nomeProduto,
                  style: TextStyle(
                      fontSize: 30, color: AppController.instance.corLetras),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'estoque atual.: ${widget.produtoList[0].objCalculosDeProdutoDoBackEnd.qtNoEstoque}',
                  style: TextStyle(
                      fontSize: 20, color: AppController.instance.corLetras),
                ),
              ),
              SizedBox(height: 30,),
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
              SizedBox(height: 30,),
              GestureDetector(
                onTap:  () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('confirma que quer '+widget.adicionarOuBaixar+ ' ?'),
                        content: Text('texto adicional'),
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
                child: WidgetsGlocais.botaoMaster(
                    context, AppController.instance.botaoConfirmar, 'salvar'),
              ),
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: WidgetsGlocais.botaoMaster(
                    context, AppController.instance.botaoNegar, 'cancelar'),
              ),
            ],
          ),
        ));
  }
}
