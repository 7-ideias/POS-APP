class ObjInformacoesDoCadastro {
  String? idDeQuemCadastrou;
  DateTime? dataCadastro;

  ObjInformacoesDoCadastro.fromJson(Map<String, dynamic> json) {
    idDeQuemCadastrou =
        json['idDeQuemCadastrou'] != null ? json['idDeQuemCadastrou'] : null;
    dataCadastro = json['dataCadastro'] != null ? json['dataCadastro'] : null;
  }
}