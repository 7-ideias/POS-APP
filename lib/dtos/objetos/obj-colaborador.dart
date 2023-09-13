import 'package:pos_app/dtos/objetos/obj-autorizacoes.dart';
import 'obj-informacoes-do-cadastro.dart';
import 'obj-pessoa-dto.dart';
import 'obj-dados-funcionais.dart';

class ObjColaborador {
  String? foto;
  String? id;
  bool? ativo;
  String? celularDeAcesso;
  String? senhaParaPermitirOAcessoDoColaborador;
  ObjInformacoesDoCadastro? objInformacoesDoCadastro;
  ObjDadosFuncionais? objDadosFuncionais;
  ObjPessoa? objPessoa;
  ObjAutorizacoes? objAutorizacoes;

  ObjColaborador.fromJson(Map<String, dynamic> json) {
    foto = json['foto'];
    id = json['id'];
    ativo = json['ativo'];
    celularDeAcesso = json['celularDeAcesso'];
    senhaParaPermitirOAcessoDoColaborador =
        json['senhaParaPermitirOAcessoDoColaborador'];
    objInformacoesDoCadastro = json['objInformacoesDoCadastro'] != null
        ? new ObjInformacoesDoCadastro.fromJson(
            json['objInformacoesDoCadastro'])
        : null;
    objDadosFuncionais = json['objDadosFuncionais'] != null
        ? new ObjDadosFuncionais.fromJson(json['objDadosFuncionais'])
        : null;
    objPessoa = json['objPessoa'] != null
        ? new ObjPessoa.fromJson(json['objPessoa'])
        : null;
    objAutorizacoes = json['objAutorizacoes'] != null
        ? new ObjAutorizacoes.fromJson(json['objAutorizacoes'])
        : null;
  }
}
