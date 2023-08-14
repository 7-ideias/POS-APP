import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dtos/produto_dto.dart';
import '../utilitarios/VariaveisGlobais.dart';

class ProdutoController {

  Future<ResponseModel> buscarProdutoList() async {

    var headers = {
      'idUsuario': '40eb39abc2f44908ae5dfc16687cc977',
      'idColaborador': '40eb39abc2f44908ae5dfc16687cc977',
      'Content-Type': 'application/json',
    };

    var body = {
      'produtosAtivos': true,
    };

    var response = await http.post(Uri.parse('https://sixbackend-70ed1c73ebec.herokuapp.com/produto/lista'), headers: headers,body: jsonEncode(body),);
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    print(response.statusCode);
    ResponseModel responseModel = ResponseModel.fromJson(jsonResponse);
    return responseModel;
  }

  Future<void> novoProduto() async {

  }

  Future<void> alterarProduto() async {

  }

}