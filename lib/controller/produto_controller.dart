import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dtos/produto_dto.dart';
import '../utilitarios/VariaveisGlobais.dart';

class ProdutoController {

  Future<http.Response> fazRequisicao() async {
    var headers = {
      'idUsuario': '${VariaveisGlobais.usuarioDto.id}',
      'idColaborador': '40eb39abc2f44908ae5dfc16687cc977',
      'Content-Type': 'application/json',
    };
    var body = {
      'produtosAtivos': true,
    };
    var response = await http.post(Uri.parse('${VariaveisGlobais.endPoint}/produto/lista'), headers: headers,body: jsonEncode(body),);
    return response;
  }


  Future<ResponseModel> buscarProdutoList(http.Response response) async {
    var headers = {
      'idUsuario': '${VariaveisGlobais.usuarioDto.id}',
      'idColaborador': '40eb39abc2f44908ae5dfc16687cc977',
      'Content-Type': 'application/json',
    };
    var body = {
      'produtosAtivos': true,
    };
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    ResponseModel responseModel = ResponseModel.fromJson(jsonResponse);
    return responseModel;
  }

  Future<void> novoProduto() async {

  }

  Future<void> alterarProduto() async {

  }

}