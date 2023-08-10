import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';
import 'dart:convert';

import '../../dtos/usuario-autenticacao-dto.dart';

class ValidaLoginTela extends StatefulWidget {
  String celular;
  String senha;
  ValidaLoginTela({Key? key, required this.celular, required this.senha}) : super(key: key);
  @override
  _ValidaLoginTelaState createState() => _ValidaLoginTelaState();
}

class _ValidaLoginTelaState extends State<ValidaLoginTela> {
  bool isLoading = true;
  String msg = 'sem msg';

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String celularQueSeraEnviadoParaValidacao = '35992736863';
    String senhaQueSeraEnviadoParaValidacao = '0000';

    var bodyDaRequisicao = {
      'celular': celularQueSeraEnviadoParaValidacao,
      'senha': senhaQueSeraEnviadoParaValidacao,
    };

    var url = '${VariaveisGlobais.endPoint}/usuario/autorizador';
    final response = await http.post(Uri.parse(url)/*,body: bodyDaRequisicao*/, headers: VariaveisGlobais.headers());
    // dynamic jsonResponse = json.decode(response.body);
    // UsuarioAutenticacaoDto list = jsonResponse.map((item) => UsuarioAutenticacaoDto.fromJson(item));

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
        msg = 'requisicao pronta - status ${response.statusCode}';
      });
    } else {
      setState(() {
        isLoading = false;
        msg = 'caiu no else';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Validação de Login'),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Text(msg),
            ),
    );
  }
}
