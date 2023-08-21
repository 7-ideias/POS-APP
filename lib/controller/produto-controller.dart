import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dtos/produto-dto-list.dart';
import '../dtos/produto-dto.dart';
import '../utilitarios/VariaveisGlobais.dart';

class ProdutoController {
//
//   List<ProdutoDto> produtoList = [];
//
//   Future<void> atualizarListaDeProdutos() async {
//     http.Response fazRequisicao = await ProdutoController().fazRequisicao();
//     if (fazRequisicao.statusCode == 200){
//       var buscarProdutoList = ProdutoController().buscarProdutoList(fazRequisicao);
//       buscarProdutoList.then((listaProdutos) {
//         produtoList = listaProdutos.produtosList;
//       }).catchError((erro) {
//         print(erro);
//       });
//     }
//   }


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


  Future<ProdutoDtoList> buscarProdutoList(http.Response response) async {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    ProdutoDtoList responseModel = ProdutoDtoList.fromJson(jsonResponse);
    return responseModel;
  }

}