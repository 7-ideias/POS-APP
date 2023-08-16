import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class RecuperandoSenha extends StatelessWidget {
  final String endpoint = "URL_DO_ENDPOINT"; // Substitua pela URL do seu endpoint

  TextEditingController celularController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController senhaController = TextEditingController();

  void enviar(BuildContext context) {
    String celular = celularController.text;

    // Fazendo a requisição GET com o número de celular como parâmetro
    http.get(Uri.parse('$endpoint?celular=$celular')).then((response) {
      if (response.statusCode == 200) {
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
        title: Text("Nova Página"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.phone,
              controller: celularController,
            ),
            ElevatedButton(
              onPressed: () => enviar(context),
              child: Text("Enviar"),
            ),
          ],
        ),
      ),
    );
  }
}