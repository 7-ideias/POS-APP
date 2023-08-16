import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NovaSenhaPage extends StatelessWidget {
  TextEditingController novaSenhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nova Senha"),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: novaSenhaController,
              obscureText: true,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Ação ao pressionar o botão "Confirmar"
              },
              child: Text("Confirmar"),
            ),
          ],
        ),
      ),
    );
  }
}