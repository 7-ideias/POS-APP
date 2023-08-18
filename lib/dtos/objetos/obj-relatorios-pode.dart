class ObjRelatoriosPode {
  bool? geraRelatorioDeVendas;

  ObjRelatoriosPode.fromJson(Map<String, dynamic> json) {
    geraRelatorioDeVendas = json['geraRelatorioDeVendas'] != null
        ? json['geraRelatorioDeVendas']
        : null;
  }
}