import 'package:pos_app/dtos/operacao-dto.dart';

class OperacaoDtoList {
  List<OperacaoDto> operacaoDto;

  OperacaoDtoList({
    required this.operacaoDto,
  });

  factory OperacaoDtoList.fromJson(List<dynamic> json) {
    var list = json.map((json) => OperacaoDto.fromJson(json)).toList();

    return OperacaoDtoList(
      operacaoDto: list,
    );
  }
}