import 'package:pos_app/dtos/push-dto.dart';

class PushDtoList {
  List<PushDto> pushNotificacoesList;

  PushDtoList({
    required this.pushNotificacoesList,
  });

  factory PushDtoList.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonList = json['pushNotificacoesList'];
    List<PushDto> lista = jsonList
        .map((elemento) => PushDto.fromJson(elemento))
        .toList();

    return PushDtoList(
      pushNotificacoesList: lista,
    );
  }
}