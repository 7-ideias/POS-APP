class ObjVendasPode {
  bool? fazVenda;
  double? comissaoDeVendas;

  ObjVendasPode.fromJson(Map<String, dynamic> json) {
    fazVenda = json['fazVenda'] != null ? json['fazVenda'] : null;
    comissaoDeVendas =
        json['comissaoDeVendas'] != null ? json['comissaoDeVendas'] : null;
  }
}