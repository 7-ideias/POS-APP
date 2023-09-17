import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_app/controller/app_controller.dart';
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

   ColaboradoresList? colaboradoresList;


  @override
  void initState() {
    super.initState();
    getColaboradorList();
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
          duration: Duration(milliseconds: 50),
          child: ListView.builder(
            itemCount:  colaboradoresList?.colaboradoresList?.length,
            itemBuilder: (context, index) {
              String isoText = colaboradoresList!.colaboradoresList![index].objPessoa?.nome ?? '';
              List<int> bytes = Latin1Codec().encode(isoText);
              String utfText = utf8.decode(bytes);
              return GestureDetector(
                onTap: () {
                  setState(() {
                    mostrarOpcoes = false;
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : RefreshIndicator(
                            onRefresh: () => getColaboradorList(),
                            child: temConteudo == true
                                ? Container(
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    height: MediaQuery.of(context).size.height * 0.2,
                                    color: AppController.instance.corTelaAcima,
                                    child: Column(
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width * 1,
                                          height: MediaQuery.of(context).size.height * 0.2,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 2, color: Colors.white),
                                          ),
                                          child: Row(
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: _getFoto(
                                                    colaboradoresList?.colaboradoresList?[index]
                                                        .foto.toString()),
                                                backgroundColor: Colors.white,
                                                radius: 60,
                                              ),
                                              Expanded(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text( utfText,
                                                          style: TextStyle(
                                                          color: AppController.instance.corLetras,
                                                          fontSize: 20,
                                                          fontWeight: FontWeight.w700,
                                                        ),
                                                          textAlign: TextAlign.left,
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Row(
                                                        children: [
                                                          Text('Tel: ${colaboradoresList!.colaboradoresList![index].objPessoa?.celular}',
                                                            style: TextStyle(
                                                              color: AppController.instance.corLetras,
                                                              fontSize: 15,
                                                              fontWeight: FontWeight.w700,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Text('Email: ${colaboradoresList!.colaboradoresList![index].objPessoa?.email}',
                                                          style: TextStyle(
                                                            color: AppController.instance.corLetras,
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w700,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Container(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const SizedBox(height: 30),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Parece que você ainda não cadastrou nenhum colaborador ainda!',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 30,
                                            color: AppController.instance.corLetras,
                                            fontFamily: 'Caprasimo'
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      SizedBox(height: 80),
                                      Lottie.asset('assets/employee-preparing-resume.json'),
                                      SizedBox(height: 50),
                                      Text('Vamos cadastrar seu primeiro colaborador?',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            fontSize: 25,
                                            color: AppController.instance.corLetras,
                                            fontFamily: 'Caprasimo'
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(
                                        height: 150,
                                          child: Transform.rotate(
                                            angle: 1.2,
                                            child: Image.asset('assets/curved-up-arrow-2.png',
                                              color: Colors.white,
                                              width: 150,

                                            ),
                                          ),),

                                    ],
                                    ),
                          ),
                  ),
                ),
                ),
              );
            },
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
    var response = await http.get(
      Uri.parse('${VariaveisGlobais.endPoint}/usuario/lista-colaboradores'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      colaboradoresList = ColaboradoresList.fromJson(jsonResponse);
      setState(() {
        temConteudo = true;
        isLoading = false;
      });
    } else {
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
      return AssetImage('assets/male-profile-picture.png');
    }
  }
}