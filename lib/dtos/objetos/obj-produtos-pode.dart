class ObjProdutosPode {
  bool? podeVerEstoqueDeProduto;
  // bool? podeEditarProduto;
  // double? valorDaComissao;

  ObjProdutosPode.fromJson(Map<String, dynamic> json) {
    podeVerEstoqueDeProduto = json['podeVerEstoqueDeProduto'] != null
        ? json['podeVerEstoqueDeProduto']
        : null;
    // podeEditarProduto =
    //     json['podeEditarProduto'] != null ? json['podeEditarProduto'] : null;
    // valorDaComissao =
    //     json['valorDaComissao'] != null ? json['valorDaComissao'] : null;
  }
}