import 'package:http/http.dart' as http;
import 'package:pos_app/controller/push-controller.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';

import 'NotificationService.dart';

/**
 * criar um endpoint com um objeto simples.
 * que o objeto tenha apenas o que deve ser atualizado.
 * isso vai evitar que existam varias consultas desnecessárias
 * {id: djlsajdljsajdsa, atualizarProdutos: true, atualizarVendas: true} <- exemplo
 */
Future<void> atualizacoesParaUsuarioService() async {
  print('vai no endPoint e pega um objeto com alteracoes para o usuario');
  // await PushController().atualizaListaDePush();
}
