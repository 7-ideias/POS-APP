class ObjComissao {
  bool? produtoTemComissaoEspecial;
  double? valorFixoDeComissaoParaEsseProduto;

  ObjComissao({
    this.produtoTemComissaoEspecial,
    this.valorFixoDeComissaoParaEsseProduto,
  });

  ObjComissao.fromJson(Map<String, dynamic> json) {
    produtoTemComissaoEspecial = json['produtoTemComissaoEspecial'] ;
    valorFixoDeComissaoParaEsseProduto = json['valorFixoDeComissaoParaEsseProduto'] ;
  }
}
