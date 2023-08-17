class ObjetoLinhaDeCredito {
  String? xxxxxxxxxxxxxxxxxxxxxxx;

  ObjetoLinhaDeCredito(
      {this.xxxxxxxxxxxxxxxxxxxxxxx});

  ObjetoLinhaDeCredito.fromJson(Map<String, dynamic> json) {
    xxxxxxxxxxxxxxxxxxxxxxx = json['testeExpiraEm'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['testeExpiraEm'] = this.xxxxxxxxxxxxxxxxxxxxxxx;
    return data;
  }
}