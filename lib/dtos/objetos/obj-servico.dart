class ObjServico {
  String? tempoDaGarantia;
  bool? podeAlterarOValorNaHora;

  ObjServico.fromJson(Map<String, dynamic> json) {
    tempoDaGarantia =
        json['tempoDaGarantia'] != null ? json['tempoDaGarantia'] : null;
    podeAlterarOValorNaHora = json['podeAlterarOValorNaHora'] != null
        ? json['podeAlterarOValorNaHora']
        : null;
  }
}