import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dtos/produto-dto-list.dart';
import '../dtos/produto-dto.dart';
import '../utilitarios/VariaveisGlobais.dart';

class ProdutoController {


  Future<void> atualizarListaDeProdutos(String produtoOuServico, bool apenasAtivos) async {
    http.Response fazRequisicao = await ProdutoController().fazRequisicao(produtoOuServico, apenasAtivos);
    if (fazRequisicao.statusCode == 200){
      var buscarProdutoList = ProdutoController().buscarProdutoList(fazRequisicao, apenasAtivos);
      buscarProdutoList.then((listaProdutos) {
        VariaveisGlobais.produtoList = listaProdutos.produtosList;
      }).catchError((erro) {
        print(erro);
      });
    }
  }


  Future<http.Response> fazRequisicao(String produtoOuServico, bool apenasAtivos) async {
    var headers = {
      'idUsuario': '${VariaveisGlobais.usuarioDto.id}',
      'idColaborador': '${VariaveisGlobais.usuarioDto.idUsuario}',
      'Content-Type': 'application/json',
    };
    var body = {
      'produtosAtivos': apenasAtivos,
      'tipo' : produtoOuServico
    };
    var response = await http.post(Uri.parse('${VariaveisGlobais.endPoint}/produto/lista'), headers: headers,body: jsonEncode(body),);
    return response;
  }


  Future<ProdutoDtoList> buscarProdutoList(http.Response response, bool apenasAtivos) async {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    ProdutoDtoList responseModel = ProdutoDtoList.fromJson(jsonResponse);
    return responseModel;
  }

}