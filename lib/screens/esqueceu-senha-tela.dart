import 'package:flutter/material.dart';

class EsqueceuTelaSenha extends StatefulWidget {
  const EsqueceuTelaSenha({Key? key}) : super(key: key);

  @override
  State<EsqueceuTelaSenha> createState() => _EsqueceuTelaSenhaState();
}

class _EsqueceuTelaSenhaState extends State<EsqueceuTelaSenha> {
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
                'fazer a tela',
                style: TextStyle(fontSize: 22),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'informar celular para o resgate',
                style: TextStyle(fontSize: 22),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.30,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(bottom: 8.0, left: 8.0, top: 8.0),
                    child: TextField(
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 22),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'pais',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      textAlign: TextAlign.right,
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontSize: 22),
                      decoration: InputDecoration(
                        suffixIcon: Icon(Icons.phone),
                        border: OutlineInputBorder(),
                        labelText: 'celular com ddd',
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  //TODO SE O STATUS CODE FOR 200, IR PARA A TELA DE DIGITAR OS CODIGOS
                  Navigator.pushReplacementNamed(context, '/esqueceuSenhaInformarSMS');
                },
                child: Text(
                  'resgatar senha',
                  style: TextStyle(fontSize: 22),
                ))
          ],
        ),
      ),
    );
  }
}
