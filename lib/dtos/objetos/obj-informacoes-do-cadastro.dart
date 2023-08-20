
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

}