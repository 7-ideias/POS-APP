import 'package:pos_app/dtos/produto-dto.dart';

class ColaboradoresList {
  List<Colaboradores>? colaboradoresList;

  ColaboradoresList(
      {
        this.colaboradoresList
      });

  factory ColaboradoresList.fromJson(Map<String, dynamic> json) {
    List<dynamic> colaboradorJson = json['colaboradoresList'];
     var list = colaboradorJson
        .map((elemento) => ProdutoDto.fromJson(elemento))
        .toList();

    return ColaboradoresList(
      id: json['id']
    );
  }
  ColaboradoresList.fromJson(Map<String, dynamic> json) {
    if (json['colaboradoresList'] != null) {
      colaboradoresList = <Colaboradores>[];
      json['colaboradoresList'].forEach((v) {
        colaboradoresList!.add(new Colaboradores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.colaboradoresList != null) {
      data['colaboradoresList'] =
          this.colaboradoresList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Colaboradores {
  String? id;

  Colaboradores({this.id});

  Colaboradores.fromJson(Map<String, dynamic> json) {
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    return data;
  }
}