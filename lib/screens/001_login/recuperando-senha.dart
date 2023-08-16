import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/screens/001_login/recuperacao-senha-confirmacao.dart';
import 'package:validatorless/validatorless.dart';

class RecuperandoSenha extends StatelessWidget {
  TextEditingController celularController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController senhaController = TextEditingController();

  void enviar(BuildContext context) {
    String celular = celularController.text;
    String endpoint = 'http://192.168.0.114:8082/usuario/recuperar-senha/+55$celular';

    http.get(Uri.parse(endpoint)).then((response) {
      if (response.statusCode == 200) {
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
      body: Form(
        key: formKey,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              TextFormField(
                validator: Validatorless.multiple([
                  Validatorless.number("Insira somente numeros"),
                  Validatorless.regex(RegExp(r'^\d{11}$'), "Número de celular inválido")
                ]),
                keyboardType: TextInputType.phone,
                controller: celularController,
              ),
              ElevatedButton(
                onPressed: () {
                  formKey.currentState?.validate();
                  enviar(context);
                },
                child: Text("Enviar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}