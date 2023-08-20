import 'package:flutter/material.dart';

import '../controller/app_controller.dart';

class RelatoriosTela extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Relatorios'),
        ),
        body: Container(
          color: AppController.instance.corTelaFundo,
        )
    );
  }
}