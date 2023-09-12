import 'objetos/obj-colaborador.dart';

class ColaboradoresList {
  List<ObjColaborador>? colaboradoresList;

  ColaboradoresList({this.colaboradoresList});

  factory ColaboradoresList.fromJson(Map<String, dynamic> json) {
    List<dynamic> colaboradorJson = json['colaboradoresList'];
    List<ObjColaborador> colaboradorList = colaboradorJson
        .map((elemento) => ObjColaborador.fromJson(elemento))
        .toList();

    return ColaboradoresList(colaboradoresList: colaboradorList);
  }
}
