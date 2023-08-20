class ObjAgrupamento{
  String? grupoDoProduto;

  ObjAgrupamento({
      this.grupoDoProduto
}
      );

  ObjAgrupamento.fromJson(Map<String, dynamic> json) {
    grupoDoProduto = json['grupoDoProduto'];
  }

}