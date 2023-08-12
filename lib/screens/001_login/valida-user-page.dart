import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';

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
    final body = jsonEncode({'celular': widget.celular, 'senha': widget.senha});

    try {
      final response = await http.post(Uri.parse(url), headers: VariaveisGlobais.headersGlobal, body: body);
          // await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        setState(() {
          status = response.statusCode;
          isLoading = false;
        });
        Timer(Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(context, '/home');
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
      appBar: AppBar(
        title: Text('ValidaPage'),
      ),
      body: Center(
        child: isLoading
            ? Lottie.asset('assets/loading.json')
            : (status == 200
                ? Lottie.asset('assets/success-mark.json')
                : Lottie.asset('assets/failed-button.json')),
      ),
    );
  }
}
