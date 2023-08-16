import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/screens/001_login/recuperacao-senha-confirmacao.dart';

class RecuperandoSenha extends StatelessWidget {
  TextEditingController celularController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController senhaController = TextEditingController();

  void enviar(BuildContext context) {
    String celular = celularController.text;
    String endpoint = 'http://192.168.1.103:8082/usuario/recuperar-senha/+55$celular';

    // Fazendo a requisição GET com o número de celular como parâmetro
    http.get(Uri.parse(endpoint)).then((response) {
      if (response.statusCode == 200) {
        // Requisição bem-sucedida, faça algo com a resposta aqui
        print(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecuperacaoSenhaConfirmacao(celular)),
        );
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