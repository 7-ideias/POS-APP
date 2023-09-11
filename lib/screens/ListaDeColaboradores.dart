import 'package:flutter/material.dart';
import 'package:pos_app/controller/app_controller.dart';

class ListaDeColaboradores extends StatefulWidget {
  const ListaDeColaboradores({super.key});

  @override
  State<ListaDeColaboradores> createState() => _ListaDeColaboradoresState();
}

class _ListaDeColaboradoresState extends State<ListaDeColaboradores> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppController.instance.corPrincipal,
      appBar: AppBar(
      ),
      body: Container(),
    );
  }
}
