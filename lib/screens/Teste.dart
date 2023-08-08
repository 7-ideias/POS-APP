import 'package:flutter/material.dart';
import '../service/NotificationService.dart';
class Teste extends StatefulWidget {
  @override
  State<Teste> createState() => _TesteState();
}

class _TesteState extends State<Teste> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('texto'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Mostrar Notificação'),
          onPressed: () {
            // _mostrarNotificacao();
            NotificationService().showNotification(title: 'Sample title', body: 'It works!');
          },
        ),
      ),
    );
  }

}