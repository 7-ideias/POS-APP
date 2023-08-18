class ObjAgrupamento {
  String? grupoDoProduto;

  ObjAgrupamento.fromJson(Map<String, dynamic> json) {
    grupoDoProduto =
        json['grupoDoProduto'] != null ? json['grupoDoProduto'] : null;
  }
}