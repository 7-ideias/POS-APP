import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:pos_app/service/NotificationService.dart';
import '../controller/push-controller.dart';
import '../dtos/push-dto.dart';
import 'VariaveisGlobais.dart';

class Rotina {
  late Timer _timer;

  void iniciarRotina() {
    _timer = Timer.periodic(Duration(seconds: 10), (timer) {
      DateTime now = DateTime.now();
        debugPrint("ROTINA SENDO FEITA - Horário atual: ${now.hour}:${now.minute}:${now.second}");
        chamarEndpoint();
    });
  }

  Future<void> chamarEndpoint() async {
      await PushController().atualizaListaDePush();
      List<PushDto> pushList = [];
      pushList = VariaveisGlobais.pushList;

    if (pushList.length > 0) {
      pushList.forEach((element) {
        NotificationService().showNotification(title: element.mensagem, body: 'valor  ${element.valorTotal}');
      });
    }else{
      debugPrint('NADA ENCONTRADO');
    }

    // NotificationService().showNotification(title: 'Sample title', body: 'element.mensagem');//fixme esse funfa sem request
  }

//   void pararRotina() {
//     // Para o timer
//     _timer?.cancel();
//   }
// }
//
// void main() {
//   final rotina = Rotina();
//   rotina.iniciarRotina(); //fixme fazer aguardar um minuto apos o app abrir
//
//   // Aguarda 5 minutos e depois para a rotina
//   // Timer(Duration(minutes: 5), () {
//   //   rotina.pararRotina();
//   // });
}
