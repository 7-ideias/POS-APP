import 'dart:io';
import 'package:flutter/material.dart';

import 'package:pos_app/utilitarios/VariaveisGlobais.dart';

class PreviewPage extends StatelessWidget {

  PreviewPage({Key? key}) : super(key: key);
  void printFileSize() {
    var sizeInBytes = VariaveisGlobais.file.lengthSync();
    var sizeInKB = sizeInBytes / 1024;
    var sizeInMB = sizeInKB / 1024;

    print('Tamanho do arquivo:');
    print('Bytes: $sizeInBytes');
    print('KB: $sizeInKB');
    print('MB: $sizeInMB');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.file(
                        VariaveisGlobais.file,
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
                                  Navigator.popUntil(context, ModalRoute.withName('/colaborador'));
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
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          Row(children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 100,top: 100),
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
                      Navigator.popUntil(context, ModalRoute.withName('/colaborador'));
                    },
                  ),
                ),
              ),
            )
          ],),
        ],
      ),
    );
  }
}
