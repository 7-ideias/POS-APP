
class ObjDadosFuncionais {
  String? dataDeContratacao;
  double? salario;

  ObjDadosFuncionais.fromJson(Map<String, dynamic> json) {
    dataDeContratacao = json['dataDeContratacao'] != null ?
    json['dataDeContratacao'] : null;
    salario = json['salario'] != null ?
    json['salario'] : null;
  }
}