class ObjCalculosDeProdutoDoBackEnd {
  double qtNoEstoque;
  double vlEstoqueEmGrana;
  DateTime ultimoDiaDeVenda;
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
      ultimoDiaDeVenda: DateTime.parse(json['ultimoDiaDeVenda']),
      ultimoVlEmGranaPagoPeloProduto: json['ultimoVlEmGranaPagoPeloProduto'],
      vlMedioDoProduto: json['vlMedioDoProduto'],
    );
  }
}