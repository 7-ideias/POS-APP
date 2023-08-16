import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'nova-senha.dart';

class RecuperacaoSenhaConfirmacao extends StatelessWidget {
  TextEditingController campo1Controller = TextEditingController();
  TextEditingController campo2Controller = TextEditingController();
  TextEditingController campo3Controller = TextEditingController();
  TextEditingController campo4Controller = TextEditingController();
  TextEditingController celularController = TextEditingController();
  final String numeroCelular;
  final String endpoint =
      "http://192.168.1.103:8082/usuario/verificacao-4-digitos";

  RecuperacaoSenhaConfirmacao(this.numeroCelular);

  void enviar(BuildContext context) {
    String numeroCelular = this.numeroCelular;
    String numero1 = campo1Controller.text;
    String numero2 = campo2Controller.text;
    String numero3 = campo3Controller.text;
    String numero4 = campo4Controller.text;

    // Construindo o corpo da requisição
    Map<String, String> body = {
      'numeroUsuario': "+55$numeroCelular",
      'code': numero1 + numero2 + numero3 + numero4,
    };
    String bodyJson = jsonEncode(body);

    // Fazendo a requisição POST
    http
        .post(
      Uri.parse(endpoint),
      headers: {'Content-Type': 'application/json'},
      body: bodyJson,
    )
        .then((response) {
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NovaSenhaPage()),
        );
        // Requisição bem-sucedida, faça algo com a resposta aqui
        print(response.body);
      } else {
        // Requisição falhou, lide com o erro aqui
        print("Erro na requisição: ${response.statusCode}");
      }
    }).catchError((error) {
      // Erro ao fazer a requisição, lide com o erro aqui
      print("Erro: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verificação"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 50,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: campo1Controller,
                    maxLength: 1,
                  ),
                ),
                Container(
                  width: 50,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: campo2Controller,
                    maxLength: 1,
                  ),
                ),
                Container(
                  width: 50,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: campo3Controller,
                    maxLength: 1,
                  ),
                ),
                Container(
                  width: 50,
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    controller: campo4Controller,
                    maxLength: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => enviar(context),
              child: const Text("Enviar"),
            ),
          ],
        ),
      ),
    );
  }
}