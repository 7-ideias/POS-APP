class ObjetoLinhaDeCredito {
  double? limite;

  ObjetoLinhaDeCredito({this.limite});

  ObjetoLinhaDeCredito.fromJson(Map<String, dynamic> json) {
    limite = json['limite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limite'] = this.limite;
    return data;
  }
}