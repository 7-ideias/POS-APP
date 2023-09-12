import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pos_app/controller/app_controller.dart';
import 'package:pos_app/dtos/objetos/obj-colaborador.dart';
import 'package:pos_app/screens/cadastrando-novo-colaborador.dart';
import 'package:http/http.dart' as http;


import '../dtos/colaborador-dto-list.dart';
import '../utilitarios/VariaveisGlobais.dart';

class ListaDeColaboradores extends StatefulWidget {
  const ListaDeColaboradores({super.key});

  @override
  State<ListaDeColaboradores> createState() => _ListaDeColaboradoresState();
}

class _ListaDeColaboradoresState extends State<ListaDeColaboradores> {
  bool mostrarOpcoes = false;
  bool isLoading = false;

  bool temConteudo = false;

  List<Colaboradores>? colaboradoresList;
  // List<ObjColaborador> colaboradorList = [];
  @override
  void initState() {
    super.initState();
    // getColaboradorList();
  }

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
                    print("xxxxxxxx");
                   getColaboradorList();
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
                        child: CircularProgressIndicator(
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () => getColaboradorList(),
                        child: temConteudo == true
                            ? Expanded(
                              child: Container(
                                  width: MediaQuery.of(context).size.width * 1,
                                  height:
                                      MediaQuery.of(context).size.height * 0.8,
                                  color: AppController.instance.corTelaAcima,
                                child: Expanded(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width * 1,
                                        height: MediaQuery.of(context).size.height * 0.2,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 2, color: Colors.white)
                                        ),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              // backgroundImage: _getFoto(colaboradorList[0].foto),
                                              backgroundColor: Colors.white,
                                              radius: 60,
                                            ),
                                            Row(

                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ),
                            )
                            : Container(child: Text('NAO TEM NENHUM COLABORADOR CADASTRADO AINDA'),),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<http.Response> getColaboradorList() async {
    setState(() {
      isLoading = true;
      temConteudo = false;
    });
    var headers = {
      'idUsuario': '${VariaveisGlobais.usuarioDto.id}',
      'Content-Type': 'application/json',
    };
    var response = await http.get(Uri.parse('${VariaveisGlobais.endPoint}/usuario/lista-colaboradores'), headers: headers,);
    if( response.statusCode == 200){
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      colaboradoresList

      // colaboradorList = jsonDecode(response.body);
      print(colaboradorListcolaboradoresList);

     setState(() {
       temConteudo = true;
       isLoading = false;
     });
    }
    else{
      temConteudo == false;
    }
    setState(() {
      isLoading = false;
    });
    return response;
  }

  ImageProvider _getFoto(String? fotoBase64) {
  if (fotoBase64 != null) {
    List<int> imageBytes = base64.decode(fotoBase64);
    Uint8List bytes = Uint8List.fromList(imageBytes);
    return MemoryImage(bytes);
  } else {
    return AssetImage('caminho/para/imagem_padrao.png');
  }
}
}
