import 'package:flutter/material.dart';
import 'package:pos_app/BaseClient.dart';

import '../../../dtos/produto-dto.dart';

class CadastroProduto extends StatefulWidget {
  @override
  _CadastroProdutoState createState() => _CadastroProdutoState();
}

class _CadastroProdutoState extends State<CadastroProduto> {
  // ProdutoDto _meuProduto = ProdutoDto(id: 'x',nomeProduto: 'xx');
  String _resposta = 'sem resposta';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Produto'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      // _meuProduto.nomeProduto = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'nome do Produto',
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      // _meuProduto.precoDeVenda = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'valor de venda',
                  ),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      // _meuProduto.precoDeCusto = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'valor de custo',
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Text(_resposta),
            ElevatedButton(
              onPressed: () async {
                var response = await BaseClient().get('').catchError((err) {
                  debugPrint(err.toString());
                });
                if (response == null) return;
                debugPrint('sucesso!!!!');
                setState(() {
                  _resposta = 'sucesso';
                });
              },
              child: Text('Enviar Produto'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                var response = await BaseClient().get('').catchError((err) {
                  debugPrint(err.toString());
                });
                if (response == null) return;
                debugPrint('sucesso!!!!');
                setState(() {
                  _resposta = 'sucesso';
                });
              },
              child: Text('Enviar API'),
            ),
            SizedBox(height: 16.0),
            // MyWidget(),
          ],
        ),
      ),
    );
  }
}
