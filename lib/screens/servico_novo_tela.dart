import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../controller/app_controller.dart';
import '../utilitarios/utils.dart';

class ServicoNovoTela extends StatefulWidget {
  const ServicoNovoTela({Key? key}) : super(key: key);

  @override
  State<ServicoNovoTela> createState() => _ServicoNovoTelaState();
}


class _ServicoNovoTelaState extends State<ServicoNovoTela> {

  DateTime dataDaEntrega = DateTime.now();
  var _informacaoInicialSobreOItem = TextEditingController();
  var _defeito = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                style: TextStyle(fontSize: 22,),
                // controller: _codigoProduto,
                // enabled: editar,
                // keyboardType: TextInputType.number,
                // inputFormatters: <TextInputFormatter>[
                //   FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                // ],
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'código',
                ),
              ),
            ),
            //data entrega
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.white
                          ),
                          height: 200,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (DateTime newDate) {
                              setState(() {
                                dataDaEntrega = newDate;
                              });
                            },
                          ),
                        );
                      },
                    );

                    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    //   elevation: 10,
                    //   duration: Duration(seconds: 5),
                    //   backgroundColor: Colors.red,
                    //   content: Text("alterar a data"),
                    // ));
                  },
                  child: Row(
                    children: [
                      Icon(Icons.date_range),
                      SizedBox(width: 10,),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: AppController.instance.buildThemeData().focusColor,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: Text(Utils.exibicaoDeData(dataDaEntrega),
                                style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Text('data entrega'),
            Divider(
              color: Colors.black,
            ),
            //informacoes sobre o item
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(fontSize: 22,),
                controller: _informacaoInicialSobreOItem,
                textAlign: TextAlign.justify,
                minLines: 1,
                maxLines: 3,
                maxLength: 300,
                decoration: InputDecoration(
                  hintText: 'adicione informações relevantes',
                   prefixIcon: GestureDetector(
                       onTap: (){
                         setState(() {
                           _informacaoInicialSobreOItem.clear();
                         });
                       },
                       child: Icon(Icons.clear)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'informações sobre o produto',
                    contentPadding: EdgeInsets.symmetric(vertical: 50.0)
                ),
              ),
            ),
            //defeito relatado
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: TextStyle(fontSize: 22,),
                controller: _defeito,
                textAlign: TextAlign.justify,
                minLines: 1,
                maxLines: 3,
                maxLength: 300,
                decoration: InputDecoration(
                    hintText: 'defeito',
                    prefixIcon: GestureDetector(
                        onTap: (){
                          setState(() {
                            _defeito.clear();
                          });
                        },
                        child: Icon(Icons.clear)),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    labelText: 'defeito/problema relatado',
                    contentPadding: EdgeInsets.symmetric(vertical: 50.0)
                ),
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Container(height: MediaQuery.of(context).size.height * .3,)
          ],
        ),
      ),
    );
  }
}
