class ObjDadosFuncionais {
  DateTime? dataDeContratacao;
  String? salario;

  ObjDadosFuncionais.fromJson(Map<String, dynamic> json) {
    dataDeContratacao =
        json['dataDeContratacao'] != null ? json['dataDeContratacao'] : null;
    salario = json['salario'] != null ? json['salario'] : null;
  }
}