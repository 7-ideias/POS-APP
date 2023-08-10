import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_app/screens/002_main/TelaPrincipal2.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter/material.dart';
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
  late var status;

  @override
  void initState() {
    super.initState();
    fazerRequisicao();
  }

  Future<void> fazerRequisicao() async {
    final url = '${VariaveisGlobais.endPoint}/usuario/autorizador';
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'celular': widget.celular, 'senha': widget.senha});

    try {
      final response = await http.post(Uri.parse(url), headers: headers, body: body);
      if (response.statusCode == 200) {
        setState(() {
          status = response.statusCode;
          isLoading = false;
        });
        Timer(Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(context, '/principal');
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
            ? Lottie.asset('assets/login-security.json')
            : (status == 200
            ? Lottie.asset('assets/success-mark.json')
            : Lottie.asset('assets/failed-button.json')),
      ),
    );
  }
}


