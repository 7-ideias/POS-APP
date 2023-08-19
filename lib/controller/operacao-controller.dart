import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pos_app/dtos/operacao-dto-list.dart';
import 'package:pos_app/dtos/operacao-dto.dart';

import '../utilitarios/VariaveisGlobais.dart';

class OperacaoController {
  Future<http.Response> fazRequisicao() async {
    var headers = {
      'idUsuario': '${VariaveisGlobais.usuarioDto.id}',
      'idColaborador': '40eb39abc2f44908ae5dfc16687cc977',
      'Content-Type': 'application/json',
    };
    var body = {
      'nadaAindaDefinidoNoFiltro': true,
    };
    var response = await http.post(
      Uri.parse('${VariaveisGlobais.endPoint}/operacao/lista'),
      headers: headers,
      body: jsonEncode(body),
    );
    return response;
  }

  Future<OperacaoDtoList> buscarOperacaoList(http.Response response) async {
    var headers = {
      'idUsuario': '${VariaveisGlobais.usuarioDto.id}',
      'idColaborador': '40eb39abc2f44908ae5dfc16687cc977',
      'Content-Type': 'application/json',
    };
    var body = {
      'produtosAtivos': true,
    };
    List<dynamic> jsonResponse = json.decode(response.body);
    print('entrou aqui');
    var operacaoDtoList = OperacaoDtoList.fromJson(jsonResponse);
    return operacaoDtoList;
  }
}
