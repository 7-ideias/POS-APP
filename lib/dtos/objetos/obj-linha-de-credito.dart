class ObjetoLinhaDeCredito {
  int? limite;//FIXME - ESSE CARA ESTA ERRADO. ELE PRECISA SER UM DOUBLE MAS O BACKA MANDANDO INTEIRO

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