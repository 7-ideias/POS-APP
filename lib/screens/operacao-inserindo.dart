import 'package:flutter/material.dart';

import '../dtos/objetos/obj-venda-e-servico.dart';

class InserindoProduto extends StatelessWidget {
  InserindoProduto({Key? key}) : super(key: key);

  ObjVendaEServico objVendaEServico = ObjVendaEServico(
    id: '',
    idCodigoProduto: '',
    codigoDeBarras: '',
    descricaoProduto: '',
    qt: 0,
    vlUnitario: 0,
    vlTotal: 0,
    idColaboradorResponsavelPeloServico: '',
    nomeColaboradorResponsavel: '',
  );

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Página'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Digite um novo item',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                objVendaEServico = ObjVendaEServico(
                    id: _controller.text
                );
                Navigator.pop(context, objVendaEServico);
              },
              child: Text('Salvar'),
            ),
          ],

        ),
      ),
    );
  }




}
