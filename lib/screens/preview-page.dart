import 'dart:io';
import 'dart:typed_data';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:pos_app/screens/cadastrando-novo-colaborador.dart';

class PreviewPage extends StatelessWidget {
  File file;

  PreviewPage({Key? key, required this.file}) : super(key: key);
  void printFileSize(File file) {
    var sizeInBytes = file.lengthSync();
    var sizeInKB = sizeInBytes / 1024;
    var sizeInMB = sizeInKB / 1024;

    print('Tamanho do arquivo:');
    print('Bytes: $sizeInBytes');
    print('KB: $sizeInKB');
    print('MB: $sizeInMB');
  }

  // Future <void> comprimirImagem() async {
  //   if(file == null) return null;
  //   XFile? imagemComprimida = await FlutterImageCompress.compressAndGetFile(
  //     file.path,
  //     file.path + '_comprimida.jpg',
  //     quality: 10,
  //   );
  //
  // }

  // Future<void> verificarTamanhoArquivoComprimido() async {
  //   if (file == null) return;
  //
  //   String caminhoImagemOriginal = file.path;
  //   int tamanhoOriginal = await File(caminhoImagemOriginal).length();
  //
  //   XFile? imagemComprimida = await FlutterImageCompress.compressAndGetFile(
  //     caminhoImagemOriginal,
  //     caminhoImagemOriginal + '_comprimida.jpg',
  //     quality: 10,
  //   );
  //
  //   if (imagemComprimida == null) return;
  //
  //   String caminhoImagemComprimida = imagemComprimida.path;
  //   int tamanhoComprimido = await File(caminhoImagemComprimida).length();
  //
  //   int diferencaTamanho = tamanhoOriginal - tamanhoComprimido;
  //
  //   print('Tamanho original do arquivo: $tamanhoOriginal bytes');
  //   print('Tamanho do arquivo comprimido: $tamanhoComprimido bytes');
  //   print('Diferença de tamanho: $diferencaTamanho bytes');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.file(
                    file,
                    fit: BoxFit.cover,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.black.withOpacity(0.5),
                          child: IconButton(
                            icon: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              printFileSize(file);
                              // comprimirImagem();
                              // print('================================================');
                              // verificarTamanhoArquivoComprimido();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      NovoColaborador(file: file),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(32.0),
                        child: CircleAvatar(
                          radius: 32,
                          backgroundColor: Colors.black.withOpacity(0.5),
                          child: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
