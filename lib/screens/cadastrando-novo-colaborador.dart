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
                  backgroundImage: widget.file != null &&  widget.file.path.isNotEmpty
                      ? AssetImage( widget.file.path)
                      : AssetImage('assets/male-profile-picture.png'),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.13,
                child: GestureDetector(
                  onTap: () => showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return buildJanelinhaQueSobe(context);
                    },
                  ),
                  child:  widget.file != null &&  widget.file.path.isNotEmpty
                      ? GestureDetector(
                          onTap: () => showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return buildJanelinhaQueSobe(context);
                              }),
                        )
                      : Lottie.asset(
                          'assets/instagram-camera.json',
                          height:
                              MediaQuery.of(context).size.height * 0.155 / 1.5,
                        ),
                ),
              ),
            ],
          ),
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
