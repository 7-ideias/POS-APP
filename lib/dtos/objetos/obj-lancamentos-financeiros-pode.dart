class ObjLancamentosFinanceirosPode {
  bool? podeReceberNoCaixa;
  bool? podeVerQuantoVendeu;

  ObjLancamentosFinanceirosPode.fromJson(Map<String, dynamic> json) {
    podeReceberNoCaixa =
        json['podeReceberNoCaixa'] != null ? json['podeReceberNoCaixa'] : null;
    podeVerQuantoVendeu = json['podeVerQuantoVendeu'] != null
        ? json['podeVerQuantoVendeu']
        : null;
  }
}