import 'package:flutter/material.dart';

class VendasTela2 extends StatefulWidget {
  const VendasTela2({Key? key}) : super(key: key);

  @override
  State<VendasTela2> createState() => _VendasTela2State();
}

class _VendasTela2State extends State<VendasTela2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Center(
              child: Text(
        'venda',
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
