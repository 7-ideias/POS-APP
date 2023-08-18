import '../feitoObjetos/obj-informacoes-do-cadastro.dart';
import '../feitoObjetos/obj-pessoa-dto.dart';
import '../obj-dados-funcionais.dart';
import '../xpto/obj-autorizacoes.dart';

class ObjColaborador {
  String? id;
  bool? ativo;
  String? celularDeAcesso;
  String? senhaParaPermitirOAcessoDoColaborador;
  ObjInformacoesDoCadastro? objInformacoesDoCadastro;
  ObjDadosFuncionais? objDadosFuncionais;
  ObjPessoa? objPessoa;
  ObjAutorizacoes? objAutorizacoes;

  ObjColaborador.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json['id'] : null;
    ativo = json['ativo'] != null ? json['ativo'] : null;
    celularDeAcesso =
        json['celularDeAcesso'] != null ? json['celularDeAcesso'] : null;
    senhaParaPermitirOAcessoDoColaborador =
        json['senhaParaPermitirOAcessoDoColaborador'] != null
            ? json['senhaParaPermitirOAcessoDoColaborador']
            : null;
    objInformacoesDoCadastro = json['objInformacoesDoCadastro'] != null
        ? json['objInformacoesDoCadastro']
        : null;
    objDadosFuncionais =
        json['objDadosFuncionais'] != null ? json['objDadosFuncionais'] : null;
    objPessoa = json['objPessoa'] != null ? json['objPessoa'] : null;
    objAutorizacoes =
        json['objAutorizacoes'] != null ? json['objAutorizacoes'] : null;
  }
}