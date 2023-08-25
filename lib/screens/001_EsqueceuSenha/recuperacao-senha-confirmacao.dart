import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

import 'nova-senha.dart';

class RecuperacaoSenhaConfirmacao extends StatefulWidget {
  final String numeroCelular;

  RecuperacaoSenhaConfirmacao(this.numeroCelular);

  @override
  _RecuperacaoSenhaConfirmacaoState createState() =>
      _RecuperacaoSenhaConfirmacaoState();
}

class _RecuperacaoSenhaConfirmacaoState
    extends State<RecuperacaoSenhaConfirmacao> {
  List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(4, (_) => FocusNode());
  final String endpoint =
      "http://192.168.0.114:8082/usuario/verificacao-4-digitos";

  String get numeroCelular => numeroCelular;

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
          MaterialPageRoute(builder: (context) => NovaSenhaPage(numeroCelular)),
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
            Container(
              child: const Text(
                'Chegou ai?',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Caprasimo',
                  color: Color(0xffC3C3C3),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: const Text(
                'Insira aqui seu codigo para redefinir sua senha',
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xffCEC10D),
                    fontFamily: 'Caprasimo'),
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(40),
              child: Lottie.asset('assets/password-protection.json'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildTextField(controllers[0], focusNodes[0]),
                buildTextField(controllers[1], focusNodes[1]),
                buildTextField(controllers[2], focusNodes[2]),
                buildTextField(controllers[3], focusNodes[3]),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                minimumSize: const Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                enviar(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => NovaSenhaPage(numeroCelular)),
                // );

              },
              child: const Text(
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                  color: Color(0xffC3C3C3),
                ),
                'Redefinir senha',
              ),
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
          borderRadius: BorderRadius.circular(10)),
      child: TextFormField(
        textAlign: TextAlign.center,
        focusNode: focusNode,
        controller: controller,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        keyboardType: TextInputType.number,
        style: const TextStyle(color: Colors.white, fontSize: 30),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}
