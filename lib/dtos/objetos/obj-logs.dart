import 'obj-informacoes-do-cadastro.dart';

class ObjLogs {
  ObjInformacoesDoCadastro? objInformacoesDoCadastro;
  String? ocorrencia;

  ObjLogs.fromJson(Map<String, dynamic> json) {
    objInformacoesDoCadastro = json['objInformacoesDoCadastro'] != null
        ? json['objInformacoesDoCadastro']
        : null;
    ocorrencia = json['ocorrencia'] != null ? json['ocorrencia'] : null;
  }
}