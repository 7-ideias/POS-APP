import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProdutoDetalheTela extends StatefulWidget {
  String idProduto;

  ProdutoDetalheTela({Key? key, required this.idProduto}) : super(key: key);

  @override
  State<ProdutoDetalheTela> createState() => _ProdutoDetalheTelaState();
}

class _ProdutoDetalheTelaState extends State<ProdutoDetalheTela> {
  final _form = GlobalKey<FormState>(); // cria  a chave para o formulario

  bool revelarTodos = false;
  bool editar = false;
  var idProduto = '';
  var _textEditingController = TextEditingController(text: 'Texto predefinido');



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.idProduto)),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          revelarTodos == true
              ? FloatingActionButton.extended(
                  onPressed: () {
                    // Ação do botão
                  },
                  label: Text('adicionar'),
                  icon: Icon(Icons.add),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          revelarTodos == true
              ? FloatingActionButton.extended(
                  onPressed: () {
                    // Ação do botão
                  },
                  label: Text('baixar'),
                  icon: Icon(Icons.remove),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          revelarTodos == true
              ? FloatingActionButton.extended(
                  onPressed: () {
                    setState(() {
                      editar = !editar;
                    });
                  },
                  label: Text('editar'),
                  icon: Icon(Icons.edit),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                )
              : Container(),
          SizedBox(
            height: 10,
          ),
          FloatingActionButton(child: Icon(Icons.question_mark),onPressed: () {
            setState(() {
              revelarTodos = !revelarTodos;
            });
          }),
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              enabled: false,
              controller: _textEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite um texto',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              enabled: editar,
              controller: _textEditingController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: widget.idProduto,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              enabled: editar,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite um número',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              enabled: editar,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'^\d{0,8}(\.\d{0,2})?$')),
              ],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Digite um número',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
