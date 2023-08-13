import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/screens/000_carregamento/TelaDeCarregamentoPrincipal.dart';
import 'package:pos_app/service/NotificationService.dart';
import 'package:pos_app/service/info-user-service.dart';
import 'package:pos_app/service/verifica-atualizacoes-para-cada-usuario.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  await infoUserService();

  //**************************************************************
  var cron = new Cron();
  cron.schedule(new Schedule.parse('*/1 * * * *'), () async {
    atualizacoesParaUsuarioService();
  });
  //
  // cron.schedule(Schedule.parse('8-11 * * * *'), () async {
  //   print('between every 8 and 11 minutes');
  // });
  //**************************************************************
  //**************************************************************
  // runApp(const App()); //TODO PARA TESTAR O RELATORIO
  //**************************************************************
  runApp(TelaDeCarregamentoPrincipal());

  // final rotina = Rotina();
  // rotina.iniciarRotina();
  //**************************************************************

  //**************************************************************
  // Aguarda 5 minutos e depois para a rotina
  // Timer(Duration(minutes: 5), () {
  //   rotina.pararRotina();
  // });
  //**************************************************************
}
