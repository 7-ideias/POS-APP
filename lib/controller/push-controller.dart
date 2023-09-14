import 'dart:convert';
import 'package:http/http.dart' as http;
import '../dtos/produto-dto-list.dart';
import '../dtos/produto-dto.dart';
import '../dtos/push-dto-list.dart';
import '../utilitarios/VariaveisGlobais.dart';

class PushController {


  Future<void> atualizaListaDePush() async {
    http.Response fazRequisicao = await PushController().fazRequisicao().timeout(const Duration(seconds: 5));
    if (fazRequisicao.statusCode == 200){
      var pushList = PushController().buscar(fazRequisicao);
      pushList.then((lista) {
        VariaveisGlobais.pushList = lista.pushNotificacoesList;
      }).catchError((erro) {
        print(erro);
      });
    }
  }

  Future<http.Response> fazRequisicao() async {
    var headers = {
      'idUsuario': '${VariaveisGlobais.usuarioDto.id}',
      'idColaborador': '${VariaveisGlobais.usuarioDto.idUsuario}',
      'Content-Type': 'application/json',
    };
    print('id da conta.: ${VariaveisGlobais.idDeQuemEstaCadastrando}');
    print('id.: ${VariaveisGlobais.usuarioDto.id}');
    print('idUsuario.: ${VariaveisGlobais.usuarioDto.idUsuario}');
    print('idDeQuemEstaCadastrando E OPERANDO.: ${VariaveisGlobais.idDeQuemEstaCadastrando}');
    print('TIPO.: ${VariaveisGlobais.usuarioDto.tipoTitularOuColaborador}');

    var response = await http.get(Uri.parse('${VariaveisGlobais.endPoint}/push/${VariaveisGlobais.idDeQuemEstaCadastrando}'), headers: headers,);
    return response;
  }


  Future<PushDtoList> buscar(http.Response response) async {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    PushDtoList responseModel = PushDtoList.fromJson(jsonResponse);
    return responseModel;
  }

}