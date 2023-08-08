import 'package:flutter/material.dart';

import '../dtos/produto_dto.dart';
import '../utilitarios/utils.dart';

class ProdutoDetalheTela extends StatefulWidget {
  ProdutoDto produtoDto;

  ProdutoDetalheTela({Key? key, required this.produtoDto}) : super(key: key);

  @override
  State<ProdutoDetalheTela> createState() => _ProdutoDetalheTelaState();
}

class _ProdutoDetalheTelaState extends State<ProdutoDetalheTela> {
  final _form = GlobalKey<FormState>(); // cria  a chave para o formulario
  var _nomeProduto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.produtoDto.nomeProduto)),
      body: ListView(
        children: [
          Utils.getEspacamento(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nomeProduto
                      ..text = widget.produtoDto.nomeProduto,
                    style: TextStyle(fontSize: 22),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'código do produto',
                    ),
                    onChanged: (value) {
                      // Lógica para tratar a mudança de valor do TextFormField, se necessário
                    },
                  ),
                  Utils.getEspacamento(),
                  TextFormField(
                    controller: _nomeProduto
                      ..text = widget.produtoDto.nomeProduto,
                    style: TextStyle(fontSize: 22),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'nome do produto',
                    ),
                    onChanged: (value) {
                      // Lógica para tratar a mudança de valor do TextFormField, se necessário
                    },
                  ),
                  Utils.getEspacamento(),
                  TextFormField(
                    controller: _nomeProduto
                      ..text = widget.produtoDto.nomeProduto,
                    style: TextStyle(fontSize: 22),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'nome do produto',
                    ),
                    onChanged: (value) {
                      // Lógica para tratar a mudança de valor do TextFormField, se necessário
                    },
                  ),
                  Utils.getEspacamento(),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green, // Altere para a cor desejada
                      ),
                      onPressed: () {},
                      child: Text('salvar',style: TextStyle(fontSize: 22),),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red, // Altere para a cor desejada
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('cancelar',style: TextStyle(fontSize: 22),),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
