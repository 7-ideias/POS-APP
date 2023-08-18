import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EsqueceuSenhaDigitarSmsTela extends StatefulWidget {
  const EsqueceuSenhaDigitarSmsTela({Key? key}) : super(key: key);

  @override
  State<EsqueceuSenhaDigitarSmsTela> createState() =>
      _EsqueceuSenhaDigitarSmsTelaState();
}

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode proximo = FocusNode();

class _EsqueceuSenhaDigitarSmsTelaState
    extends State<EsqueceuSenhaDigitarSmsTela> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'informe o codigo sms',
                style: TextStyle(fontSize: 22),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widgetCampoDigitacao(),
                widgetCampoDigitacao(),
                widgetCampoDigitacao(),
                widgetCampoDigitacao(),
                widgetCampoDigitacao(),
                widgetCampoDigitacao(),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  //TODO SE O STATUS CODE FOR 200, IR PARA A TELA DE DIGITAR OS CODIGOS

                  //TODO SE NAO DER O 200 CHAMA A TELA DE LOGIN
                },
                child: Text(
                  'validar',
                  style: TextStyle(fontSize: 22),
                ))
          ],
        ),
      ),
    );
  }

  SizedBox widgetCampoDigitacao() {
    return SizedBox(
                width: MediaQuery.of(context).size.width * 0.13,
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 8.0, left: 8.0, top: 8.0),
                  child: TextField(
                    maxLength: 1,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 22),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              );
  }
}
