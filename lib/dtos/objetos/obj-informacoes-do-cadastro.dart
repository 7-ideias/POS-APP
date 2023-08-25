
class ObjInformacoesDoCadastro {
  String? idDeQuemCadastrou;
  DateTime? dataCadastro;

  ObjInformacoesDoCadastro({
    this.idDeQuemCadastrou,
    this.dataCadastro,
  });

  factory ObjInformacoesDoCadastro.fromJson(Map<String, dynamic> json) {
    return ObjInformacoesDoCadastro(
      idDeQuemCadastrou: json['idDeQuemCadastrou'],
      dataCadastro: DateTime.parse(json['dataCadastro']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idDeQuemCadastrou'] = this.idDeQuemCadastrou;
    data['dataCadastro'] = this.dataCadastro?.toIso8601String();
    return data;
  }

}