class ObjDadosDoEstoque {
  double? estoqueAtual;
  double? estoqueMinimo;
  double? estoqueMaximo;

  ObjDadosDoEstoque.fromJson(Map<String, dynamic> json) {
    estoqueAtual = json['estoqueAtual'] != null ? json['estoqueAtual'] : null;
    estoqueMinimo =
        json['estoqueMinimo'] != null ? json['estoqueMinimo'] : null;
    estoqueMaximo =
        json['estoqueMaximo'] != null ? json['estoqueMaximo'] : null;
  }
}