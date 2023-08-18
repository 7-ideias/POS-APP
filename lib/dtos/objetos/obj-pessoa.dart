import 'obj-endereco.dart';
import '../feitoObjetos/obj-linha-de-credito.dart';

class ObjPessoa {
  String? atencao;
  String? nome;
  String? nomeDeGuerra;
  String? celular;
  String? senha;
  String? cpf;
  String? rg;
  String? dataDeNascimento;
  String? email;
  ObjEndereco? objEndereco;
  ObjetoLinhaDeCredito? objetoLinhaDeCredito;

  ObjPessoa.fromJson(Map<String, dynamic> json) {
    atencao = json['atencao'] != null ? json['atencao'] : null;
    nome = json['nome'] != null ? json['nome'] : null;
    nomeDeGuerra = json['nomeDeGuerra'] != null ? json['nomeDeGuerra'] : null;
    celular = json['celular'] != null ? json['celular'] : null;
    senha = json['senha'] != null ? json['senha'] : null;
    cpf = json['cpf'] != null ? json['cpf'] : null;
    rg = json['rg'] != null ? json['rg'] : null;
    dataDeNascimento =
        json['dataDeNascimento'] != null ? json['dataDeNascimento'] : null;
    email = json['email'] != null ? json['email'] : null;
    objEndereco = json['objEndereco'] != null ? json['objEndereco'] : null;
    objetoLinhaDeCredito = json['objetoLinhaDeCredito'] != null
        ? json['objetoLinhaDeCredito']
        : null;
  }
}