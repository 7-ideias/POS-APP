import 'package:flutter/material.dart';

class LoginDeUmUsuarioAtivo extends StatefulWidget {
  @override
  _LoginDeUmUsuarioAtivoState createState() => _LoginDeUmUsuarioAtivoState();
}

class _LoginDeUmUsuarioAtivoState extends State<LoginDeUmUsuarioAtivo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Validar'),
        actions: [Icon(Icons.help)],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Digite seu celular para fazer\n a validação',
                style: TextStyle(fontSize: 22),textAlign: TextAlign.center),
            SizedBox(height:20,),
            ElevatedButton(
              onPressed: () {
                //TODO chamar a api de back para mandar o SMS
                //TODO chamar a proxima tela para digitar o codigo que chegou no SMS
                //TODO SE O CARA ESQUECEU A SENHA, VALIDAR NOVAMENTE O CELULAR
              },
              child: Text('validar celular'),
            ),
          ],
        ),
      ),
    );
  }
}
