import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:pos_app/service/info-user-service.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';
import 'package:pos_app/utilitarios/tela_inteira.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/voltar_a_tela_de_encolha.dart';
import 'home-tela.dart';
import 'jornada-tela.dart';

class ValidaPage extends StatefulWidget {
  final String celular;
  final String senha;
  final String celularTitular;

  /**
   * USUARIO - se chegar usuario é porque quer apenas logar
   * COLABORADOR - o colaborador nao pode ser cadastrado por ele mesmo. Apenas pelo seu USUARIO (DONO DA CONTA)
   * NOVO - esse será um novo USUARIO
   */
  final String usuarioColaboradorNovo;


  ValidaPage({required this.celular, required this.senha,
    required this.celularTitular, required this.usuarioColaboradorNovo});

  @override
  _ValidaPageState createState() => _ValidaPageState();
}

class _ValidaPageState extends State<ValidaPage> {
  bool isLoading = true;
  var status = 401;

  @override
  void initState() {
    super.initState();
    fazerRequisicao();
  }

  Future<void> fazerRequisicao() async {

    String url = '';

    if(widget.usuarioColaboradorNovo == 'NOVO'){
      url = '${VariaveisGlobais.endPoint}/usuario/novo';
      VariaveisGlobais.tipoTitularOuColaborador = 'TITULAR';
    }
    if(widget.usuarioColaboradorNovo == 'COLABORADOR'){
      url = '${VariaveisGlobais.endPoint}/usuario/autorizador-colaborador';
      VariaveisGlobais.tipoTitularOuColaborador = 'COLABORADOR';
    }
    if(widget.usuarioColaboradorNovo == 'USUARIO'){
      url = '${VariaveisGlobais.endPoint}/usuario/autorizador';
      VariaveisGlobais.tipoTitularOuColaborador = 'TITULAR';
    }


    // if(widget.colaborador == true){
    //   url = '${VariaveisGlobais.endPoint}/usuario/autorizador-colaborador';
    // }else{
    //   url = '${VariaveisGlobais.endPoint}/usuario/autorizador';
    // }

    print('URL.: ' + url);
    print('printando');

    var headers = {
      'idUser':'5dab33ff2a8c4d6690547e33708fa2b1',
      'celularDoTitular' : widget.celularTitular,
      // 'idUsuario': '40eb39abc2f44908ae5dfc16687cc977',
      // 'idColaborador': '40eb39abc2f44908ae5dfc16687cc977',
      'Content-Type': 'application/json',
    };

    var body = {
      'celular': widget.celular,
      'senha' : widget.senha
    };

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: jsonEncode(body));
      if (response.statusCode == 200 || response.statusCode == 201) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(VariaveisGlobais.PREFERENCIASDOUSUARIO, response.body);

        setState(() {
          infoUserService();
          status = response.statusCode;
          isLoading = false;
        });

        Timer(Duration(seconds: 3), () {
          // Navigator.pushReplacementNamed(context, '/home');
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>Home()),(Route<dynamic> route) => false);
        });
      }
      // if (response.statusCode == 409 && widget.usuarioColaboradorNovo == 'NOVO') {
      //   setState(() {
      //     status = response.statusCode;
      //     isLoading = false;
      //   });
      //   Timer(Duration(seconds: 2), () {
      //   });
      //
      // }
      else {
        setState(() {
          status = response.statusCode;
          isLoading = false;
        });
        Timer(Duration(seconds: 2), () {
          voltarEscolha(context);
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      Timer(Duration(seconds: 3), () {
        Navigator.pushReplacementNamed(context, '/login');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? TelaInteira().widgetDeLoadingPadraoDoApp()
            : (status == 200 || status == 201
                ? Lottie.asset('assets/success-mark.json')
                : Lottie.asset('assets/failed-button.json')),
      ),
    );
  }


}
