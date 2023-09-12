class ColaboradoresList {
  List<Colaboradores>? colaboradoresList;


  ColaboradoresList({this.colaboradoresList});

  factory ColaboradoresList.fromJson(Map<String, dynamic> json) {
    List<dynamic> colaboradorJson = json['colaboradoresList'];
    List<Colaboradores> colaboradorList = colaboradorJson
        .map((elemento) => Colaboradores.fromJson(elemento))
        .toList();

    return ColaboradoresList(colaboradoresList: colaboradorList);
  }
}

class Colaboradores {
  String? id;

  Colaboradores({this.id});

  Colaboradores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }
}
