import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../utilitarios/VariaveisGlobais.dart';

class VendaTela extends StatefulWidget {
  @override
  _VendaTelaState createState() => _VendaTelaState();
}

class _VendaTelaState extends State<VendaTela> {
  TextEditingController campo1Controller = TextEditingController();
  TextEditingController campo2Controller = TextEditingController();
  TextEditingController campo3Controller = TextEditingController();
  TextEditingController campo4Controller = TextEditingController();
  TextEditingController campo5Controller = TextEditingController();
  bool isLoading = false;

  void enviarRequisicao() async {
    setState(() {
      isLoading = true;
    });

    var vendaData = {
      'registroMovimentacao': campo1Controller.text,
      'codigoProduto': campo2Controller.text,
      'quantidadeInformada': campo3Controller.text,
      'campo4': campo4Controller.text,
      'campo5': campo5Controller.text,
    };

    var vendaJson = json.encode(vendaData);
    var url = Uri.parse('${VariaveisGlobais.endPoint}/inserir/movimentacao');
    var response = await http.post(url,
        body: vendaJson, headers: VariaveisGlobais.headers());
    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      dialogFalouComunicacao(context);
    }
    setState(() {
      isLoading = false;
    });
  }

  void dialogFalouComunicacao(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erro'),
          content: Text('Falha na requisição.'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Venda'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity * 0.6,
                  child: TextField(
                    controller: campo1Controller,
                    decoration: InputDecoration(labelText: 'Campo 1'),
                  ),
                ),
                SizedBox(
                  width: double.infinity * 0.6,
                  child: TextField(
                    controller: campo2Controller,
                    decoration: InputDecoration(labelText: 'código do produto'),
                  ),
                ),
                SizedBox(
                  width: double.infinity * 0.6,
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: campo3Controller,
                    decoration: InputDecoration(labelText: 'quantidade'),
                  ),
                ),
                SizedBox(
                  width: double.infinity * 0.6,
                  child: TextField(
                    controller: campo4Controller,
                    decoration: InputDecoration(labelText: 'Campo 4'),
                  ),
                ),
                SizedBox(
                  width: double.infinity * 0.6,
                  child: TextField(
                    controller: campo5Controller,
                    decoration: InputDecoration(labelText: 'Campo 5'),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  child: Text('Enviar'),
                  onPressed: isLoading ? null : enviarRequisicao,
                ),
                SizedBox(height: 20),
                if (isLoading) CircularProgressIndicator(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
