import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_app/controller/app_controller.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:pos_app/screens/preview-page.dart';

class NovoColaborador extends StatefulWidget {
  final File file;

  const NovoColaborador({super.key, required this.file});

  @override
  State<NovoColaborador> createState() => _NovoColaboradorState();
}

class _NovoColaboradorState extends State<NovoColaborador> {
  late File arquivo = File('');

  final picker = ImagePicker();

  Future chamaAGaleria() async {
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        arquivo = File(file.path);
      });
    }
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            style: TextStyle(color: AppController.instance.corLetras),
            'Novo colaborador'),
      ),
      body: ListView(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.center,
            children: [
              Container(
                color: AppController.instance.corPrincipal,
                child: Image.asset('assets/employee-data-folder.png'),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.22,
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.09,
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.height * 0.155 / 1.8,
                  backgroundColor: Colors.white,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.1,
                child: CircleAvatar(
                  radius: MediaQuery.of(context).size.height * 0.155 / 2,
                  backgroundColor: Colors.grey,
                  backgroundImage:
                      widget.file != null && widget.file.path.isNotEmpty
                          ? AssetImage(widget.file.path)
                          : AssetImage('assets/male-profile-picture.png'),
                ),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height * 0.13,
                  child: widget.file != null && widget.file.path.isNotEmpty
                      ? GestureDetector(
                          onTap: () => showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return buildJanelinhaQueSobe(context);
                              }),
                        )
                      : GestureDetector(
                          onTap: () => showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return buildJanelinhaQueSobe(context);
                            },
                          ),
                          child: Lottie.asset(
                            'assets/instagram-camera.json',
                            height: MediaQuery.of(context).size.height *
                                0.155 /
                                1.5,
                          ),
                        )),
            ],
          ),
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Card(
              color: Colors.purple,
              child: Container(
                height: MediaQuery.of(context).size.height*0.8,
                color: AppController.instance.corPrincipal,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: Text('Nome'),
                          labelStyle: TextStyle(
                            color: AppController.instance.corLetras,
                            fontSize: 20,
                            fontWeight: FontWeight.w300
                          ),
                          border: OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
                          suffixIcon: Icon(Icons.person,
                            color: AppController.instance.corTelaAcima,
                          )
                        ),
                      ),
                    ),//nome
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            label: Text('Email'),
                            labelStyle: TextStyle(
                                color: AppController.instance.corLetras,
                                fontSize: 20,
                                fontWeight: FontWeight.w300
                            ),
                            border: OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
                            suffixIcon: Icon(Icons.email,
                              color: AppController.instance.corTelaAcima,
                            )
                        ),
                      ),
                    ),//email
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            label: Text('Telefone de acesso'),
                            labelStyle: TextStyle(
                                color: AppController.instance.corLetras,
                                fontSize: 20,
                                fontWeight: FontWeight.w300
                            ),
                            border: OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
                            suffixIcon: Icon(Icons.phone,
                              color: AppController.instance.corTelaAcima,
                            )
                        ),
                      ),
                    ),//telefone
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  label: Text('RG'),
                                  labelStyle: TextStyle(
                                      color: AppController.instance.corLetras,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300
                                  ),
                                  border: OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
                                  suffixIcon: Icon(Icons.account_box_outlined,
                                    color: AppController.instance.corTelaAcima,
                                  )
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  label: Text('CPF'),
                                  labelStyle: TextStyle(
                                      color: AppController.instance.corLetras,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300
                                  ),
                                  border: OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
                                  suffixIcon: Icon(Icons.people_alt_outlined,
                                    color: AppController.instance.corTelaAcima,
                                  )
                              ),
                            ),
                          ),
                        ),
                      ],
                    ), //rg e cpf
                    Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 12.0, bottom: 8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.datetime,
                          decoration: InputDecoration(
                              label: Text('Data de nascimento'),
                              labelStyle: TextStyle(
                                  color: AppController.instance.corLetras,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300
                              ),
                              border: OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
                              suffixIcon: Icon(Icons.cake,
                                color: AppController.instance.corTelaAcima,
                              )
                          ),
                        ),
                      ), // data nascimento
                    Row(
                      children: [
                        Expanded(
                          child: Text('———Dados endereço———',
                          textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                              color: AppController.instance.corLetras,
                              fontSize: 20
                            ),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                        child: Card(
                          color: AppController.instance.corTelaAcima,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: TextFormField(
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                  label: Text('CEP'),
                                  labelStyle: TextStyle(
                                      color: AppController.instance.corLetras,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300
                                  ),
                                  border: OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
                                  suffixIcon: Icon(Icons.home,
                                    color: AppController.instance.corTelaAcima,
                                  )
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container buildJanelinhaQueSobe(BuildContext context) {
    return Container(
      height: 120,
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt),
            title: Text('Camera'),
            onTap: () {
              Navigator.pop(context); // Fechar a janela
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => CameraCamera(
                          onFile: (file) {
                            showPreview(file);
                            Navigator.pop(context);
                            setState(() {
                              arquivo = file;
                            });
                          },
                        )),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.photo),
            title: Text('Galeria'),
            onTap: () {
              chamaAGaleria();
            },
          ),
        ],
      ),
    );
  }

  showPreview(file) async {
    file = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreviewPage(file: file),
        ));
    if (file != null) {
      setState(() {
        arquivo = file;
      });
      Get.back();
    }
  }
}
