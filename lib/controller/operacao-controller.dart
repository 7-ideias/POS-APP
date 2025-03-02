import 'dart:convert';

import 'package:http/http.dart' as http;

import '../dtos/operacao-dto-nova.dart';
import '../utilitarios/VariaveisGlobais.dart';

class OperacaoController {
  Future<http.Response> fazRequisicao() async {
    var headers = {
      'idUsuario': '${VariaveisGlobais.usuarioDto.id}',
      'idColaborador': '${VariaveisGlobais.usuarioDto.idUsuario}',
      'Content-Type': 'application/json',
    };
    var body = {
      'nadaAindaDefinidoNoFiltro': true,
    };
    var response = await http.post( Uri.parse('${VariaveisGlobais.endPoint}/operacao/lista'), headers: headers, body: jsonEncode(body),
    );
    return response;
  }

  Future<void> atualizarOperacoes() async {
    http.Response fazRequisicao = await OperacaoController().fazRequisicao();
    if (fazRequisicao.statusCode == 200){
      var result = OperacaoController().buscarProdutoList(fazRequisicao);
      result.then((value) => VariaveisGlobais.operacoesBackEnd = value);
    }else{
      // VariaveisGlobais.operacoesBackEnd.ops?.clear();
      VariaveisGlobais.operacoesBackEnd.ops = null;
    }
  }

  Future<OperacoesDoBackEnd> buscarProdutoList(http.Response response) async {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    OperacoesDoBackEnd responseModel = OperacoesDoBackEnd.fromJson(jsonResponse);
    return responseModel;
  }

  Future<http.Response> excluirOperacaoPorID (String id) async {
    var url = '${VariaveisGlobais.endPoint}/operacao/apagar/' + id;
    String idDeQuemEstaCadastrando = '${VariaveisGlobais.usuarioDto.id}';
    var headers = {
      'Content-Type': 'application/json',
      'idUsuario': '${VariaveisGlobais.usuarioDto.id}',
      'idColaborador': idDeQuemEstaCadastrando
    };
    var response = await http.delete(Uri.parse(url), headers: headers);
    return response;
  }

}
