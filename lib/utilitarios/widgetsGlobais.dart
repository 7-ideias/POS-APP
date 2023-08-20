import 'package:flutter/material.dart';

import '../controller/app_controller.dart';

class WidgetsGlocais {

  static Widget botaoMaster(BuildContext context, Color colors, String texto) {
    return Card(
      elevation: 10,
      color: colors,
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.white70, width: 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        decoration: BoxDecoration(
        ),
        width: MediaQuery.of(context).size.width *0.8,
        height: 50,
        child: Center(
          child: Text(
            texto,style: TextStyle(fontSize: AppController.instance.botaoTamanhoLetras),
          ),
        ),
      ),
    );
  }



  //modelo alert
/*

onPressed:  (context) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Enviar a venda para o caixa?'),
                                content: Text('isso deixa a venda pronta para ser recebida'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Cancelar'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('ok'),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
 */

}
