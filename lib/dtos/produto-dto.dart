class ProdutoDto {
  String id;
  String codigoDeBarras;
  String nomeProduto;
  ObjCalculosDeProdutoDoBackEnd objCalculosDeProdutoDoBackEnd;
  double precoVenda;
  bool ativo;

  ProdutoDto({
    required this.id,
    required this.codigoDeBarras,
    required this.nomeProduto,
    required this.objCalculosDeProdutoDoBackEnd,
    required this.precoVenda,
    required this.ativo,
  });

  factory ProdutoDto.fromJson(Map<String, dynamic> json) {
    return ProdutoDto(
      id: json['id'],
      codigoDeBarras: json['codigoDeBarras'],
      nomeProduto: json['nomeProduto'],
      objCalculosDeProdutoDoBackEnd: ObjCalculosDeProdutoDoBackEnd.fromJson(json['objCalculosDeProdutoDoBackEnd']),
      precoVenda: json['precoVenda'],
      ativo: json['ativo'],
    );
  }
}

class ObjCalculosDeProdutoDoBackEnd {
  double qtNoEstoque;
  double vlEstoqueEmGrana;
  String ultimoDiaDeVenda;
  double ultimoVlEmGranaPagoPeloProduto;
  double vlMedioDoProduto;

  ObjCalculosDeProdutoDoBackEnd({
    required this.qtNoEstoque,
    required this.vlEstoqueEmGrana,
    required this.ultimoDiaDeVenda,
    required this.ultimoVlEmGranaPagoPeloProduto,
    required this.vlMedioDoProduto,
  });

  factory ObjCalculosDeProdutoDoBackEnd.fromJson(Map<String, dynamic> json) {
    return ObjCalculosDeProdutoDoBackEnd(
      qtNoEstoque: json['qtNoEstoque'],
      vlEstoqueEmGrana: json['vlEstoqueEmGrana'],
      ultimoDiaDeVenda: json['ultimoDiaDeVenda'],
      ultimoVlEmGranaPagoPeloProduto: json['ultimoVlEmGranaPagoPeloProduto'],
      vlMedioDoProduto: json['vlMedioDoProduto'],
    );
  }
}