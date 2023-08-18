class ObjetoLinhaDeCredito {
  double? limite;

  ObjetoLinhaDeCredito.fromJson(Map<String, dynamic> json) {
    limite = json['limite'] != null ? json['limite'] : null;
  }
}