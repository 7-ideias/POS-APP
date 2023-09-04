import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:pos_app/screens/home-tela.dart';
import 'package:pos_app/screens/leitor_de_codigos_de_barras.dart';
import 'package:pos_app/screens/tela_index_1_principal.dart';
import 'package:pos_app/utilitarios/tela_inteira.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/idioma_controller.dart';
import '../utilitarios/VariaveisGlobais.dart';
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
      body: isLoading == true ? TelaInteira().widgetDeLoadingPadraoDoApp() :
      SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: Colors.deepPurple,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              right: 0,
              child: Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30))
              ),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              child: Lottie.asset('assets/people-doing-international-communication.json', fit: BoxFit.contain),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30))
                ),
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            Positioned(
              left: 45,
              bottom: 100,
              child: Container(
                width: MediaQuery.of(context).size.width * .8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(
                      spacing: 30,
                      runSpacing: 30,
                      direction: Axis.horizontal,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home(),));
                            getIdioma('pt-br');
                          },
                          child: SizedBox(
                            height: altura(),
                            width: altura(),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              alignment: Alignment.center,
                              child: Text('portugues\nbrasil',style : GoogleFonts.bebasNeue(fontSize: 22,color: Colors.white)),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Leitor(),));
                            getIdioma('en-us');
                          },
                          child: SizedBox(
                            height: altura(),
                            width: altura(),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.circular(10)),
                              alignment: Alignment.center,
                              child: Text('ingles',style : GoogleFonts.bebasNeue(fontSize: 22,color: Colors.white)),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            getIdioma('es-419');
                          },
                          child: SizedBox(
                            height: altura(),
                            width: altura(),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(10)),
                              alignment: Alignment.center,
                              child: Text('espanhol\nlatino',style : GoogleFonts.bebasNeue(fontSize: 22,color: Colors.white)),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            // fazerRequisicao('es-419');
                          },
                          child: SizedBox(
                            height: altura(),
                            width: altura(),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(10)),
                              alignment: Alignment.center,
                              child: Text('portugues\nangola',style : GoogleFonts.bebasNeue(fontSize: 22,color: Colors.white)),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double altura() => 140;


  Future<void> getIdioma(String idiomaEscolhido) async {

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
          // isLoading = false;
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
