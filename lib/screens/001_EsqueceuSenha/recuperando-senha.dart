import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:pos_app/screens/001_EsqueceuSenha/recuperacao-senha-confirmacao.dart';
import 'package:validatorless/validatorless.dart';

class RecuperandoSenha extends StatefulWidget {
  @override
  State<RecuperandoSenha> createState() => _RecuperandoSenhaState();
}

class _RecuperandoSenhaState extends State<RecuperandoSenha> {

  TextEditingController celularController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController senhaController = TextEditingController();

  String get numeroCelular => celularController.text;

  void enviar(BuildContext context) {
    String celular = celularController.text;
    String heroku = 'http://192.168.0.114:8082/usuario/recuperar-senha/';
    String endpoint = '$heroku+55$celular';

    http.get(Uri.parse(endpoint)).then((response) {
      if (response.statusCode == 202) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RecuperacaoSenhaConfirmacao(celular)),
        );
        print("Deu bom: ${response.statusCode}");
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
      body: Container(
        color: const Color(0xFF003366),
        child: Form(
          key: formKey,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text(
                    'Deixa com a gente!',
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
                    'Enviaremos um SMS para confirmar sua identidade, isso levará um segundo!',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xffCEC10D),
                      fontFamily: 'Caprasimo'
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Lottie.asset('assets/password-security.json'),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: TextFormField(
                    validator: Validatorless.multiple([
                      Validatorless.number("Insira somente numeros"),
                      Validatorless.regex(RegExp(r'^\d{11}$'), "Número de celular inválido")
                    ]),
                    keyboardType: TextInputType.phone,
                    controller: celularController,
                    style: const TextStyle(
                      color: Colors.white
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Digite seu numero de telefone',
                      labelStyle: TextStyle(
                        color: Color(0xffcec10d),
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                      contentPadding: EdgeInsets.only(right: 30, left: 30),
                    ),
                  ),
                ),
                 const SizedBox(
                  height: 35
                ),
                ElevatedButton(
                  onPressed: () {
                    formKey.currentState?.validate();
                    enviar(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => RecuperacaoSenhaConfirmacao(numeroCelular)),
                    // );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                    minimumSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Color(0xffC3C3C3),
                  ),
                  "Enviar sms"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}