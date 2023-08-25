import 'package:pos_app/dtos/objetos/obj-calculos-de-operacao-do-back-end.dart';
import 'package:pos_app/dtos/objetos/obj-informacoes-do-cadastro.dart';
import 'package:pos_app/dtos/objetos/obj-venda-e-servico-list.dart';

import 'objetos/obj-agenda.dart';
import 'objetos/obj-logs-list.dart';
import 'objetos/obj-recebimento-list.dart';
import 'objetos/obj-recebimentos.dart';
import 'objetos/obj-venda-e-servico.dart';

class OperacoesDoBackEnd {
  double? totalEmGrana;
  int? quantidadeDeOps;
  List<Ops>? ops;

  OperacoesDoBackEnd({
    this.totalEmGrana,
    this.quantidadeDeOps,
    this.ops
  });

  OperacoesDoBackEnd.fromJson(Map<String, dynamic> json) {
    totalEmGrana = json['totalEmGrana'];
    quantidadeDeOps = json['quantidadeDeOps'];
    if (json['ops'] != null) {
      ops = <Ops>[];
      json['ops'].forEach((v) {
        ops!.add(Ops.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalEmGrana'] = this.totalEmGrana;
    data['quantidadeDeOps'] = this.quantidadeDeOps;
    if (this.ops != null) {
      data['ops'] = this.ops!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ops {
  String? id;
  String? idUsuario;
  String? codigoProprioDaOperacao;
  String? descricao;
  ObjInformacoesDoCadastro? objInformacoesDoCadastro;
  String? tipoDeOperacaoEnum;
  bool? statusQuitada;
  bool? operacaoFinalizadaEProntaParaOCaixa;
  ObjCalculosDeOperacaoDoBackEnd? objCalculosDeOperacaoDoBackEnd;
  Null? objAgenda;
  List<ObjVendaEServico>? vendaList;
  List<VendaList>? servicoList;
  Null? objRecebimentosList;
  List<ObjLogsList>? objLogsList;

  Ops(
      {this.id,
        this.idUsuario,
        this.codigoProprioDaOperacao,
        this.descricao,
        this.objInformacoesDoCadastro,
        this.tipoDeOperacaoEnum,
        this.statusQuitada,
        this.operacaoFinalizadaEProntaParaOCaixa,
        this.objCalculosDeOperacaoDoBackEnd,
        this.objAgenda,
        this.vendaList,
        this.servicoList,
        this.objRecebimentosList,
        this.objLogsList});

  Ops.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUsuario = json['idUsuario'];
    codigoProprioDaOperacao = json['codigoProprioDaOperacao'];
    descricao = json['descricao'];
    // objInformacoesDoCadastro = json['objInformacoesDoCadastro'] != null
    //     ? new ObjInformacoesDoCadastro.fromJson(
    //     json['objInformacoesDoCadastro'])
    //     : null;
    // tipoDeOperacaoEnum = json['tipoDeOperacaoEnum'];
    // statusQuitada = json['statusQuitada'];
    // operacaoFinalizadaEProntaParaOCaixa =
    // json['operacaoFinalizadaEProntaParaOCaixa'];
    objCalculosDeOperacaoDoBackEnd = ObjCalculosDeOperacaoDoBackEnd.fromJson( json['objCalculosDeOperacaoDoBackEnd']);
    // objAgenda = json['objAgenda'];
    if (json['vendaList'] != null) {
      vendaList = <ObjVendaEServico>[];
      json['vendaList'].forEach((v) {
        vendaList!.add(new ObjVendaEServico.fromJson(v));
      });
    }
    // servicoList = json['servicoList'];
    // objRecebimentosList = json['objRecebimentosList'];
    // if (json['objLogsList'] != null) {
    //   objLogsList = <ObjLogsList>[];
    //   json['objLogsList'].forEach((v) {
    //     objLogsList!.add(new ObjLogsList.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idUsuario'] = this.idUsuario;
    data['codigoProprioDaOperacao'] = this.codigoProprioDaOperacao;
    data['descricao'] = this.descricao;
    if (this.objInformacoesDoCadastro != null) {
      data['objInformacoesDoCadastro'] =
          this.objInformacoesDoCadastro!.toJson();
    }
    data['tipoDeOperacaoEnum'] = this.tipoDeOperacaoEnum;
    data['statusQuitada'] = this.statusQuitada;
    data['operacaoFinalizadaEProntaParaOCaixa'] =
        this.operacaoFinalizadaEProntaParaOCaixa;
    if (this.objCalculosDeOperacaoDoBackEnd != null) {
      data['objCalculosDeOperacaoDoBackEnd'] =
          this.objCalculosDeOperacaoDoBackEnd!.toJson();
    }
    data['objAgenda'] = this.objAgenda;
    if (this.vendaList != null) {
      data['vendaList'] = this.vendaList!.map((v) => v.toJson()).toList();
    }
    data['servicoList'] = this.servicoList;
    data['objRecebimentosList'] = this.objRecebimentosList;
    if (this.objLogsList != null) {
      data['objLogsList'] = this.objLogsList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ObjInformacoesDoCadastro {
  String? idDeQuemCadastrou;
  String? dataCadastro;

  ObjInformacoesDoCadastro({this.idDeQuemCadastrou, this.dataCadastro});

  ObjInformacoesDoCadastro.fromJson(Map<String, dynamic> json) {
    idDeQuemCadastrou = json['idDeQuemCadastrou'];
    dataCadastro = json['dataCadastro'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idDeQuemCadastrou'] = this.idDeQuemCadastrou;
    data['dataCadastro'] = this.dataCadastro;
    return data;
  }
}

// class ObjCalculosDeOperacaoDoBackEnd {
//   double? vlTotal;
//   bool? operacaoTotalmenteRecebida;
//
//   ObjCalculosDeOperacaoDoBackEnd(
//       {this.vlTotal, this.operacaoTotalmenteRecebida});
//
//   ObjCalculosDeOperacaoDoBackEnd.fromJson(Map<String, dynamic> json) {
//     vlTotal = json['vlTotal'];
//     operacaoTotalmenteRecebida = json['operacaoTotalmenteRecebida'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['vlTotal'] = this.vlTotal;
//     data['operacaoTotalmenteRecebida'] = this.operacaoTotalmenteRecebida;
//     return data;
//   }
// }

class VendaList {
  String? id;
  String? idCodigoProduto;
  String? codigoDeBarras;
  String? descricaoProduto;
  int? qt;
  int? vlUnitario;
  int? vlTotal;
  Null? idColaboradorResponsavelPeloServico;
  String? nomeColaboradorResponsavel;

  VendaList(
      {this.id,
        this.idCodigoProduto,
        this.codigoDeBarras,
        this.descricaoProduto,
        this.qt,
        this.vlUnitario,
        this.vlTotal,
        this.idColaboradorResponsavelPeloServico,
        this.nomeColaboradorResponsavel});

  VendaList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCodigoProduto = json['idCodigoProduto'];
    codigoDeBarras = json['codigoDeBarras'];
    descricaoProduto = json['descricaoProduto'];
    qt = json['qt'];
    vlUnitario = json['vlUnitario'];
    vlTotal = json['vlTotal'];
    idColaboradorResponsavelPeloServico =
    json['idColaboradorResponsavelPeloServico'];
    nomeColaboradorResponsavel = json['nomeColaboradorResponsavel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idCodigoProduto'] = this.idCodigoProduto;
    data['codigoDeBarras'] = this.codigoDeBarras;
    data['descricaoProduto'] = this.descricaoProduto;
    data['qt'] = this.qt;
    data['vlUnitario'] = this.vlUnitario;
    data['vlTotal'] = this.vlTotal;
    data['idColaboradorResponsavelPeloServico'] =
        this.idColaboradorResponsavelPeloServico;
    data['nomeColaboradorResponsavel'] = this.nomeColaboradorResponsavel;
    return data;
  }
}

class ObjLogsList {
  ObjInformacoesDoCadastro? objInformacoesDoCadastro;
  String? ocorrencia;

  ObjLogsList({this.objInformacoesDoCadastro, this.ocorrencia});

  ObjLogsList.fromJson(Map<String, dynamic> json) {
    objInformacoesDoCadastro = json['objInformacoesDoCadastro'] != null
        ? new ObjInformacoesDoCadastro.fromJson(
        json['objInformacoesDoCadastro'])
        : null;
    ocorrencia = json['ocorrencia'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.objInformacoesDoCadastro != null) {
      data['objInformacoesDoCadastro'] =
          this.objInformacoesDoCadastro!.toJson();
    }
    data['ocorrencia'] = this.ocorrencia;
    return data;
  }
}