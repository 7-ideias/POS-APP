import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/service/NotificationService.dart';
import '../dtos/push-dto.dart';
import 'VariaveisGlobais.dart';

class Rotina {
  late Timer _timer;

  void iniciarRotina() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      DateTime now = DateTime.now();
      print("ROTINA SENDO FEITA - Horário atual: ${now.hour}:${now.minute}:${now.second}");
      chamarEndpoint();//fixme
    });
  }

  Future<void> chamarEndpoint() async {
    print('iniciando request');
    var url = Uri.parse('${VariaveisGlobais.endPoint}/push');
    print('iniciando request endPoint.: '+url.toString());
    //

    try{

    var response = await http.get(url).timeout(Duration(seconds: 5));
    print('request feita');

    print(response.statusCode);

    List<dynamic> jsonResponse = json.decode(response.body);
    List<PushDto> pushList = [];
    pushList = jsonResponse.map((item) => PushDto.fromJson(item)).toList();

    print('proximo eh o service');

    if (pushList.length > 0) {
      pushList.forEach((element) {
        NotificationService()
            .showNotification(title: element.mensagem, body: 'valor R\$ ${element.valorTotal}');
      });
    }
    } catch(_) {
      debugPrint('ERRO NA REQUISICAO');
    }

    // NotificationService().showNotification(title: 'Sample title', body: 'element.mensagem');//fixme esse funfa sem request
  }

  void pararRotina() {
    // Para o timer
    _timer?.cancel();
  }
}

void main() {
  final rotina = Rotina();
  rotina.iniciarRotina(); //fixme fazer aguardar um minuto apos o app abrir

  // Aguarda 5 minutos e depois para a rotina
  // Timer(Duration(minutes: 5), () {
  //   rotina.pararRotina();
  // });
}
