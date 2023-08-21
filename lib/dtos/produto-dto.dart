import 'package:pos_app/dtos/objetos/obj-agrupamento.dart';
import 'package:pos_app/dtos/objetos/obj-informacoes-do-cadastro.dart';

import 'objetos/obj-calculos-de-produto-do-back-end.dart';
import 'objetos/obj-comissao.dart';

class ProdutoDto {
  String id;
  String codigoDeBarras;
  String nomeProduto;
  ObjCalculosDeProdutoDoBackEnd objCalculosDeProdutoDoBackEnd;
  double precoVenda;
  bool ativo;
  String idUsuario;
  String tipoPoduto;
  ObjInformacoesDoCadastro objInformacoesDoCadastro;
  ObjAgrupamento objAgrupamento;
  String? objServico;
  String modeloProduto;
  double estoqueMaximo;
  double estoqueMinimo;
  ObjComissao objComissao;

  ProdutoDto({
    required this.id,
    required this.codigoDeBarras,
    required this.nomeProduto,
    required this.objCalculosDeProdutoDoBackEnd,
    required this.precoVenda,
    required this.ativo,
    required this.idUsuario,
    required this.tipoPoduto,
    required this.objInformacoesDoCadastro,
    required this.objAgrupamento,
    required this.objServico,
    required this.modeloProduto,
    required this.estoqueMaximo,
    required this.estoqueMinimo,
    required this.objComissao,
  });

  factory ProdutoDto.fromJson(Map<String, dynamic> json) {
    return ProdutoDto(
      id: json['id'],
      codigoDeBarras: json['codigoDeBarras'],
      nomeProduto: json['nomeProduto'],
      objCalculosDeProdutoDoBackEnd: ObjCalculosDeProdutoDoBackEnd.fromJson(json['objCalculosDeProdutoDoBackEnd']),
      precoVenda: json['precoVenda'],
      ativo: json['ativo'],
      idUsuario: json['idUsuario'],
      tipoPoduto : json['tipoPoduto'],
      objInformacoesDoCadastro :  ObjInformacoesDoCadastro.fromJson(json['objInformacoesDoCadastro']),
      objAgrupamento: ObjAgrupamento.fromJson(json['objAgrupamento']),
      objServico: json['objServico'],
      modeloProduto: json['modeloProduto'],
      estoqueMaximo: json['estoqueMaximo'],
      estoqueMinimo: json['estoqueMinimo'],
      objComissao : ObjComissao.fromJson(json['objComissao']),

    );
  }
}
