import 'package:flutter/material.dart';

class CaixaTela extends StatefulWidget {
  const CaixaTela({Key? key}) : super(key: key);

  @override
  State<CaixaTela> createState() => _CaixaTelaState();
}

class _CaixaTelaState extends State<CaixaTela> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
              child: Text(
        'caixa',
        textAlign: TextAlign.center,
      ))),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: () {
              // Ação do botão
            },
            label: Text('nova venda'),
            icon: Icon(Icons.add),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FloatingActionButton(
              child: Icon(Icons.cancel),
              onPressed: () {
                Navigator.pop(context);
              }),
        ],
      ),
      body: Container(
          // color: Colors.red,
          ),
    );
  }
}
