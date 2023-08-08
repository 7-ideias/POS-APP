import 'package:flutter/material.dart';

class LoginDeUmUsuarioNovo extends StatefulWidget {
  @override
  _LoginDeUmUsuarioNovoState createState() => _LoginDeUmUsuarioNovoState();
}

class _LoginDeUmUsuarioNovoState extends State<LoginDeUmUsuarioNovo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuario novo'),
        actions: [Icon(Icons.help)],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Usuario novo', style: TextStyle(fontSize: 22),textAlign: TextAlign.center),
            SizedBox(height:20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  label: Text('celular'),
                  border: OutlineInputBorder(

                  )
                ),
                keyboardType: TextInputType.phone,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                //TODO MANDA PARA A API CHECAR SE O CELULAR EXISTE NA BASE (VERIFICAR SE EXISTE NA BASE DE CELULAR ATRIBUIDO A UM COLABORADOR)
                //TODO SE O USUARIO EXISTE COMO COLABORADOR, PRECISA TER A OPÇAO DE LOGAR NA CONTA QUE ELE É UM COLABORADOR OU LOGAR EM UMA OUTRA CONTA,
                //TODO POIS EU IMAGINO O CENARIO QUE O CARA É UM COLABORADOR
              },
              child: Text('novo'),
            ),
          ],
        ),
      ),
    );
  }
}
