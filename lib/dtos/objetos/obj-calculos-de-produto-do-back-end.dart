class ObjCalculosDeProdutoDoBackEnd {
  double? qtNoEstoque;
  double? vlEstoqueEmGrana;
  DateTime? ultimoDiaDeVenda;
  double? ultimoVlEmGranaPagoPeloProduto;
  double? vlMedioDoProduto;

  ObjCalculosDeProdutoDoBackEnd.fromJson(Map<String, dynamic> json) {
    qtNoEstoque = json['qtNoEstoque'] != null ? json['qtNoEstoque'] : null;
    vlEstoqueEmGrana =
        json['vlEstoqueEmGrana'] != null ? json['vlEstoqueEmGrana'] : null;
    ultimoDiaDeVenda =
        json['ultimoDiaDeVenda'] != null ? json['ultimoDiaDeVenda'] : null;
    ultimoVlEmGranaPagoPeloProduto =
        json['ultimoVlEmGranaPagoPeloProduto'] != null
            ? json['ultimoVlEmGranaPagoPeloProduto']
            : null;
    vlMedioDoProduto =
        json['vlMedioDoProduto'] != null ? json['vlMedioDoProduto'] : null;
  }
}
