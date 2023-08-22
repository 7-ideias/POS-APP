import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:pos_app/main.dart';
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
  String _backgroundImage =
      'assets/rio-de-janeiro-in-brazil.png'; // imagem inicial
  bool isLoading = false;
  var status = 401;

  String _idioma = 'Português';

  String _idiomaRequisicao = 'pt-br';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? Center(child: VariaveisGlobais().widgetDeLoadingPadraoDoApp())
          : Stack(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(_backgroundImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Column(
                  children: [
                    Expanded(
                      child: ListWheelScrollView(
                        itemExtent: 250,
                        physics: const FixedExtentScrollPhysics(),
                        onSelectedItemChanged: (index) {
                          setState(() {
                            switch (index) {
                              case 0:
                                _idiomaRequisicao = 'pt-br';
                                _idioma = 'Português';
                                _backgroundImage =
                                    'assets/rio-de-janeiro-in-brazil.png';
                                break;
                              case 1:
                                _idiomaRequisicao = 'en-us';
                                _idioma = 'English';
                                _backgroundImage =
                                    'assets/statue-of-liberty.png';
                                break;
                              case 2:
                                _idiomaRequisicao = 'es-419';
                                _idioma = 'Español';
                                _backgroundImage = 'assets/xpto.jpeg';
                                break;
                              default:
                                _idiomaRequisicao = 'pt-br';
                                _idioma = 'Português';
                                _backgroundImage =
                                    'assets/rio-de-janeiro-in-brazil.png';
                            }
                          });
                        },
                        children: [
                          GestureDetector(
                            onTap: () {
                              fazerRequisicao('pt-br');
                            },
                            child: SizedBox(
                                height: 100,
                                width: 200,
                                child: Lottie.asset(
                                  'assets/brazil-flag.json',
                                )),
                          ),
                          GestureDetector(
                            onTap: () {
                              fazerRequisicao('en-us');
                            },
                            child: SizedBox(
                                height: 100,
                                width: 200,
                                child: Lottie.asset('assets/usa.json')),
                          ),
                          GestureDetector(
                            onTap: () {
                              fazerRequisicao('es-419');
                            },
                            child: SizedBox(
                                height: 100,
                                width: 200,
                                child: Lottie.asset('assets/spain.json')),
                          ),
                          // Text(VariaveisGlobais.idiomaDto.bomDia.toString()),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.width * 0.25),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: GestureDetector(
                      onTap: () {
                        fazerRequisicao(_idiomaRequisicao);
                      },
                      child: Container(
                        width: 276,
                        height: 46,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xff66a3d2)),
                        child: Center(
                          child: Text(
                            _idioma,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.width*0.25),
                    child: const Text(
                      'Escolha seu idioma',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Future<void> fazerRequisicao(String idiomaEscolhido) async {
    setState(() {
      isLoading = true;
    });

    final url = '${VariaveisGlobais.endPoint}/idioma/' + idiomaEscolhido;
    print('URL.: ' + url);

    var headers = {
      'idUser': 'appPOS',
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
        Timer(const Duration(seconds: 2), () {
          // Navigator.pushReplacementNamed(context, '/login');
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      Timer(const Duration(seconds: 3), () {
        // Navigator.pushReplacementNamed(context, '/login');
      });
    }
  }
}
