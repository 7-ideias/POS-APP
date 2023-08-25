import 'package:pos_app/dtos/objetos/obj-calculos-de-operacao-do-back-end.dart';
import 'package:pos_app/dtos/objetos/obj-informacoes-do-cadastro.dart';
import 'package:pos_app/dtos/objetos/obj-venda-e-servico-list.dart';

import 'objetos/obj-agenda.dart';
import 'objetos/obj-logs-list.dart';
import 'objetos/obj-recebimento-list.dart';
import 'objetos/obj-recebimentos.dart';
import 'objetos/obj-venda-e-servico.dart';

class OperacaoDto {
  final String id;
  final String idUsuario;
  final String codigoProprioDaOperacao;
  final String descricao;
  final ObjInformacoesDoCadastro? objInformacoesDoCadastro;
  final String tipoDeOperacaoEnum;
  final bool statusQuitada;
  final bool operacaoFinalizadaEProntaParaOCaixa;
  final ObjCalculosDeOperacaoDoBackEnd objCalculosDeOperacaoDoBackEnd;
  final ObjAgenda? objAgenda;
  List<ObjVendaEServico>? vendaList;
  List<ObjVendaEServico>? servicoList;
  ObjRecebimentosList? objRecebimentosList;
  ObjLogsList? objLogsList;

  OperacaoDto({
    required this.id,
    required this.idUsuario,
    required this.codigoProprioDaOperacao,
    required this.descricao,
    this.objInformacoesDoCadastro,
    required this.tipoDeOperacaoEnum,
    required this.statusQuitada,
    required this.operacaoFinalizadaEProntaParaOCaixa,
    required this.objCalculosDeOperacaoDoBackEnd,
    this.objAgenda,
    this.vendaList,
    this.servicoList,
    this.objRecebimentosList,
    this.objLogsList,
  });

  factory OperacaoDto.fromJson(Map<String, dynamic> json) {
    return OperacaoDto(
      id: json['id'],
      idUsuario: json['idUsuario'],
      codigoProprioDaOperacao: json['codigoProprioDaOperacao'],
      descricao: json['descricao'],
      objInformacoesDoCadastro: ObjInformacoesDoCadastro.fromJson(json['objInformacoesDoCadastro']),
      tipoDeOperacaoEnum: json['tipoDeOperacaoEnum'],
      statusQuitada: json['statusQuitada'],
      operacaoFinalizadaEProntaParaOCaixa: json['operacaoFinalizadaEProntaParaOCaixa'],
      objCalculosDeOperacaoDoBackEnd: ObjCalculosDeOperacaoDoBackEnd.fromJson(json['objCalculosDeOperacaoDoBackEnd']),
      objAgenda: json['objAgenda'] != null ? ObjAgenda.fromJson(json['objAgenda']) : null,
      vendaList : json['vendaList']!= null ?json['vendaList'] : null,
      servicoList : json['servicoList']!= null ?json['servicoList'] : null,
      objRecebimentosList : json['objRecebimentosList'] != null ? ObjRecebimentosList.fromJson(json['objRecebimentosList'])!= null ? ObjRecebimentosList.fromJson(json['objRecebimentosList']): null : null,
      // objLogsList : json['objLogsList'] != null ? ObjLogsList.fromJson(json['objLogsList'])!= null ? ObjLogsList.fromJson(json['objLogsList']): null : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idUsuario'] = this.idUsuario;
    data['codigoProprioDaOperacao'] = this.codigoProprioDaOperacao;
    data['descricao'] = this.descricao;
    data['objInformacoesDoCadastro'] = this.objInformacoesDoCadastro?.toJson();
    data['tipoDeOperacaoEnum'] = this.tipoDeOperacaoEnum;
    data['statusQuitada'] = this.statusQuitada;
    data['operacaoFinalizadaEProntaParaOCaixa'] = this.operacaoFinalizadaEProntaParaOCaixa;
    data['objCalculosDeOperacaoDoBackEnd'] = this.objCalculosDeOperacaoDoBackEnd.toJson();
    data['objAgenda'] = this.objAgenda != null ? this.objAgenda?.toJson() : null;
    data['vendaList'] = this.vendaList;
    // data['servicoList'] = this.servicoList != null ? this.servicoList!.toJson() : null;
    // data['objRecebimentosList'] = this.objRecebimentosList != null ? this.objRecebimentosList!.toJson() : null;
    // data['objLogsList'] = this.objLogsList != null ? this.objLogsList!.toJson() : null;
    return data;
  }
}
