import 'package:pos_app/dtos/objetos/obj-calculos-de-operacao-do-back-end.dart';
import 'package:pos_app/dtos/objetos/obj-informacoes-do-cadastro.dart';
import 'package:pos_app/dtos/objetos/obj-venda-e-servico-list.dart';

import 'objetos/obj-agenda.dart';
import 'objetos/obj-logs-list.dart';
import 'objetos/obj-recebimento-list.dart';
import 'objetos/obj-recebimentos.dart';

class OperacaoDto {
  final String id;
  final String idUsuario;
  final String codigoProprioDaOperacao;
  final String descricao;
  final ObjInformacoesDoCadastro objInformacoesDoCadastro;
  final String tipoDeOperacaoEnum;
  final bool statusQuitada;
  final bool operacaoFinalizadaEProntaParaOCaixa;
  final ObjCalculosDeOperacaoDoBackEnd? objCalculosDeOperacaoDoBackEnd;
  final ObjAgenda? objAgenda;
  ObjVendaEServicoList? vendaList;
  ObjVendaEServicoList? servicoList;
  ObjRecebimentosList? objRecebimentosList;
  ObjLogsList? objLogsList;

  OperacaoDto({
    required this.id,
    required this.idUsuario,
    required this.codigoProprioDaOperacao,
    required this.descricao,
    required this.objInformacoesDoCadastro,
    required this.tipoDeOperacaoEnum,
    required this.statusQuitada,
    required this.operacaoFinalizadaEProntaParaOCaixa,
    this.objCalculosDeOperacaoDoBackEnd,
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
      vendaList : ObjVendaEServicoList.fromJson(json['vendaList'])!= null ?ObjVendaEServicoList.fromJson(json['vendaList']): null,
      servicoList :         ObjVendaEServicoList.fromJson(json['servicoList'])!= null ?ObjVendaEServicoList.fromJson(json['servicoList']): null,
      objRecebimentosList : json['objRecebimentosList'] != null ? ObjRecebimentosList.fromJson(json['objRecebimentosList'])!= null ? ObjRecebimentosList.fromJson(json['objRecebimentosList']): null : null,
      // objLogsList : json['objLogsList'] != null ? ObjLogsList.fromJson(json['objLogsList'])!= null ? ObjLogsList.fromJson(json['objLogsList']): null : null,
    );
  }
}
