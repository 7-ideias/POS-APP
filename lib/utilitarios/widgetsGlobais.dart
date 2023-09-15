import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos_app/utilitarios/texto_ajuda.dart';

import '../controller/app_controller.dart';

class UtilsWidgets {

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
            texto,style: TextStyle(fontSize: AppController.instance.botaoTamanhoLetras,
          color: AppController.instance.corLetras
          ),
          ),
        ),
      ),
    );
  }

  static Widget textFormField(bool obscureText, bool enabled, double tamanhoLetra,String msgValidador,
      TextEditingController controlador, TextInputType keyboardType, String labelText, String prefixText, TextDirection direcao){

    var filteringTextInputFormatter;

    if(keyboardType == TextInputType.number){
      filteringTextInputFormatter = FilteringTextInputFormatter.allow(RegExp(r'[0-9]'));
    }else if(keyboardType == TextInputType.numberWithOptions(decimal: true)){
      filteringTextInputFormatter = FilteringTextInputFormatter.allow(RegExp(r'^\d{0,8}(\.\d{0,2})?$'));
    }

    return   TextFormField(
      textAlign: TextAlign.right,
      enabled: enabled,
      obscureText: obscureText,
      textDirection: direcao,
      validator: (valorAValidar) {
        if (valorAValidar == null || valorAValidar.isEmpty) {
          return msgValidador;
        }
        return null;
      },
      style: TextStyle(fontSize: tamanhoLetra),
      controller: controlador,
      keyboardType: keyboardType,
      inputFormatters: <TextInputFormatter>[filteringTextInputFormatter],
      decoration: buildInputDecoration(labelText, prefixText),
    );
  }

  static InputDecoration buildInputDecoration(String labelText,String prefixText ) {
    return InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(60)),
      enabledBorder:
      OutlineInputBorder(borderRadius: BorderRadius.circular(60)),
      focusedBorder:
      OutlineInputBorder(borderRadius: BorderRadius.circular(60)),
      labelText: labelText,
      prefixText: prefixText,
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

  static FloatingActionButton floatDeAjuda(BuildContext context, String texto) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.redAccent,
      onPressed: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Ajuda'),
              elevation: 10,
              content: Text(texto),
              actions: <Widget>[
                TextButton(
                  child: Text('ok'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
      label: Row(
        children: [
          Icon(Icons.question_mark),
          Text('ajuda' ),
        ],
      ),
    );
  }

}
