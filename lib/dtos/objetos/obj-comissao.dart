class ObjComissao {
  bool? produtoTemComissaoEspecial;
  double? valorFixoDeComissaoParaEsseProduto;

  ObjComissao.fromJson(Map<String, dynamic> json) {
    produtoTemComissaoEspecial = json['produtoTemComissaoEspecial'] != null
        ? json['produtoTemComissaoEspecial']
        : null;
    valorFixoDeComissaoParaEsseProduto =
        json['valorFixoDeComissaoParaEsseProduto'] != null
            ? json['valorFixoDeComissaoParaEsseProduto']
            : null;
  }
}
