import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/main.dart';
import 'package:pos_app/utilitarios/tela_inteira.dart';
import '../controller/idioma_controller.dart';
import '../utilitarios/VariaveisGlobais.dart';
import 'dart:async';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'jornada-tela.dart';

class IdiomaTela extends StatefulWidget {
  const IdiomaTela({Key? key}) : super(key: key);

  @override
  State<IdiomaTela> createState() => _IdiomaTelaState();
}

class _IdiomaTelaState extends State<IdiomaTela> {

  bool isLoading = false;
  var status = 401;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true ? Center(child: TelaInteira().widgetDeLoadingPadraoDoApp()) : Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  fazerRequisicao('pt-br');
                },
                child: SizedBox(
                  height: 100,
                  width: 200,
                  child: Container(
                    color: Colors.green,
                    alignment: Alignment.center,
                    child: Text('portugues brasil'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  fazerRequisicao('en-us');
                },
                child: SizedBox(
                  height: 100,
                  width: 200,
                  child: Container(
                    color: Colors.redAccent,
                    alignment: Alignment.center,
                    child: Text('ingles'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: (){
                  fazerRequisicao('es-419');
                },
                child: SizedBox(
                  height: 100,
                  width: 200,
                  child: Container(
                    color: Colors.orange,
                    alignment: Alignment.center,
                    child: Text('espanhol america latina'),
                  ),
                ),
              ),
            ),
            Text(VariaveisGlobais.idiomaDto.bomDia.toString())
          ],
        ),
      ),
    );
  }


  Future<void> fazerRequisicao(String idiomaEscolhido) async {

    setState(() {
      isLoading = true;
    });

    final url = '${VariaveisGlobais.endPoint}/idioma/'+idiomaEscolhido;
    print('URL.: ' + url);

    var headers = {
      'idUser':'appPOS',
      'Content-Type': 'application/json',
    };

    try {
      final response = await http.get(Uri.parse(url), headers: headers);
      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(VariaveisGlobais.IDIOMADOAPP, response.body);

        setState(() {
          Idioma.instance.mudarIdioma();
          status = response.statusCode;
          isLoading = false;
        });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => JornadaTela()),
          );

      } else {
        setState(() {
          status = response.statusCode;
          isLoading = false;
        });
        Timer(Duration(seconds: 2), () {
          // Navigator.pushReplacementNamed(context, '/login');
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      Timer(Duration(seconds: 3), () {
        // Navigator.pushReplacementNamed(context, '/login');
      });
    }
  }


}
