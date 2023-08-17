import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../001_login/nova-senha.dart';

class RecuperacaoSenhaConfirmacao extends StatefulWidget {
  final String numeroCelular;

  RecuperacaoSenhaConfirmacao(this.numeroCelular);

  @override
  _RecuperacaoSenhaConfirmacaoState createState() => _RecuperacaoSenhaConfirmacaoState();
}

class _RecuperacaoSenhaConfirmacaoState extends State<RecuperacaoSenhaConfirmacao> {
  List<TextEditingController> controllers = List.generate(4, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());
  final String endpoint =
      "http://192.168.0.114:8082/usuario/verificacao-4-digitos";

  void enviar(BuildContext context) {
    String numeroCelular = this.widget.numeroCelular;
    String numero1 = controllers[0].text;
    String numero2 = controllers[1].text;
    String numero3 = controllers[2].text;
    String numero4 = controllers[3].text;

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
  void initState() {
    super.initState();
    for (int i = 0; i < controllers.length; i++) {
      controllers[i].addListener(() {
        if (controllers[i].text.isNotEmpty) {
          FocusScope.of(context).requestFocus(focusNodes[i + 1]);
        }
      });
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xFF003366),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTextField(controllers[0], focusNodes[0]),
                buildTextField(controllers[1], focusNodes[1]),
                buildTextField(controllers[2], focusNodes[2]),
                buildTextField(controllers[3], focusNodes[3]),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: (
                  ) {
                enviar(context);
                // Implementar a lógica para enviar o código
              },
              child: Text('Enviar Código'),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget buildTextField(TextEditingController controller, FocusNode focusNode) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(10)
      ),
      child: TextFormField(
        textAlign: TextAlign.center,
        focusNode: focusNode,
        controller: controller,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        keyboardType: TextInputType.number,
        style: TextStyle(color: Colors.white, fontSize: 30),
        decoration: InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}
  