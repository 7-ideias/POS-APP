import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pos_app/controller/app_controller.dart';
import 'package:pos_app/screens/cadastrando-novo-colaborador.dart';

class ListaDeColaboradores extends StatefulWidget {
  const ListaDeColaboradores({super.key});

  @override
  State<ListaDeColaboradores> createState() => _ListaDeColaboradoresState();
}

class _ListaDeColaboradoresState extends State<ListaDeColaboradores> {
  bool mostrarOpcoes = false;
  bool isLoading = true;

  bool temConteudo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppController.instance.corPrincipal,
      appBar: AppBar(
        title: Text(
            style: TextStyle(color: AppController.instance.corLetras),
            'Seus colaboradores'),
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (mostrarOpcoes == true)
            FloatingActionButton.extended(
              backgroundColor: Colors.blue,
              onPressed: () {
                setState(() {
                  mostrarOpcoes = false;
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NovoColaborador(file: File(''))),
                );
              },
              label: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.add),
                  Text('Inserir novo colaborador'),
                ],
              ),
            ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (mostrarOpcoes == false)
                FloatingActionButton(
                  child: Text('+', style: TextStyle(fontSize: 30)),
                  onPressed: () {
                    setState(() {
                      mostrarOpcoes = !mostrarOpcoes;
                    });
                  },
                ),
            ],
          ),
          SizedBox(height: 20),
          if (mostrarOpcoes == false)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  child: const Icon(Icons.refresh),
                  onPressed: () {
                    setState(() {});
                  },
                ),
              ],
            ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          if (mostrarOpcoes) {
            setState(() {
              mostrarOpcoes = false;
            });
          }
        },
        child: AnimatedOpacity(
          opacity: mostrarOpcoes == true ? 0.1 : 1,
          duration: Duration(seconds: 1),
          child: ListView(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    mostrarOpcoes = false;
                  });
                },
                child: Container(
                  color: Colors.transparent,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : RefreshIndicator(
                        onRefresh: () => (_),
                        child: temConteudo == true
                            ? Container(
                                width: MediaQuery.of(context).size.width * 1,
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                color: Colors.red,
                              )
                            : Container(),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
