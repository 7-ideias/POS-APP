
class ObjInformacoesDoCadastro {
  final String idDeQuemCadastrou;
  final String dataCadastro;

  ObjInformacoesDoCadastro({
    required this.idDeQuemCadastrou,
    required this.dataCadastro,
  });

  factory ObjInformacoesDoCadastro.fromJson(Map<String, dynamic> json) {
    return ObjInformacoesDoCadastro(
      idDeQuemCadastrou: json['idDeQuemCadastrou'],
      dataCadastro: json['dataCadastro'],
    );
  }

}