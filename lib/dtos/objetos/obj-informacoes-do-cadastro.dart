
class ObjInformacoesDoCadastro {
  String? idDeQuemCadastrou;
  String? dataCadastro;

  ObjInformacoesDoCadastro.fromJson(Map<String, dynamic> json) {
    idDeQuemCadastrou = json['idDeQuemCadastrou'];
    dataCadastro = json['dataCadastro'];
  }

}