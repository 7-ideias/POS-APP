import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CepEnvio extends StatefulWidget {
  @override
  _CepEnvioState createState() => _CepEnvioState();
}

class _CepEnvioState extends State<CepEnvio> {
  TextEditingController _cepController = TextEditingController();
  String _response = '';

  Future<void> _sendCep() async {
    String cep = 'nulo';
    cep = _cepController.text;
    // Endpoint URL
    String url = 'app-carlos-342ad7b4d60c.herokuapp.com/cep2/$cep';
    try {
      // Send GET request
      http.Response response = await http.get(Uri.parse(url));
      // Parse JSON response
      // Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      // Extract "cep" from JSON response
      // String cepResponse = 'FUNFOU';
      print((response.statusCode));
      // String cepResponse = jsonResponse['cep'];
      setState(() {
        _response = 'sucesso';
      });
    } catch (e) {
      setState(() {
        _response = 'Erro ao enviar o CEP.';
      });
    }
  }

  Future<void> requisicaoNovaParaTeste() async {
    final url = 'https://app-carlos-342ad7b4d60c.herokuapp.com/cep/37600000';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      // final data = jsonDecode(response.body);
      // Faça algo com os dados retornados
      print('okkkkkkkkkkkkkkkkkk');
    } else {
      print('Erro ao fazer a requisição: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Envio de CEP'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _cepController,
              decoration: InputDecoration(
                labelText: 'CEP',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _sendCep,
              child: Text('Enviar'),
            ),
            SizedBox(height: 16.0),
            SizedBox(height: 16.0),
            Text('Resposta do Endpoint: $_response'),
          ],
        ),
      ),
    );
  }
}
