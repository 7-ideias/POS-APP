import 'package:flutter/material.dart';

import '../dtos/produto_dto.dart';
import '../utilitarios/utils.dart';

class ProdutoDetalheTela extends StatefulWidget {
  String idProduto;

  ProdutoDetalheTela({Key? key, required this.idProduto}) : super(key: key);

  @override
  State<ProdutoDetalheTela> createState() => _ProdutoDetalheTelaState();
}

class _ProdutoDetalheTelaState extends State<ProdutoDetalheTela> {
  final _form = GlobalKey<FormState>(); // cria  a chave para o formulario
  var _nomeProduto = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.idProduto)),
    );
  }
}
