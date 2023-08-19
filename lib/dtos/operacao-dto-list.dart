import 'package:pos_app/dtos/operacao-dto.dart';

class OperacaoDtoList {
  List<OperacaoDto> produtosList;

  OperacaoDtoList({
    required this.produtosList,
  });

  factory OperacaoDtoList.fromJson(List<dynamic> json) {
    var list = json.map((json) => OperacaoDto.fromJson(json)).toList();

    return OperacaoDtoList(
      produtosList: list,
    );
  }
}