import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:pos_app/service/info-user-service.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';
import 'package:pos_app/utilitarios/tela_inteira.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home-tela.dart';

class ValidaPage extends StatefulWidget {
  final String celular;
  final String senha;

  ValidaPage({required this.celular, required this.senha});

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
    final url = '${VariaveisGlobais.endPoint}/usuario/autorizador';
    print('URL.: ' + url);

    var headers = {
      'idUser':'appPOS',
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
      } else {
        setState(() {
          status = response.statusCode;
          isLoading = false;
        });
        Timer(Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, '/login');
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
