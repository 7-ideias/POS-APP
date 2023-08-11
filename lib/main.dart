import 'package:flutter/material.dart';
import 'package:pos_app/app/app.dart';
import 'package:pos_app/desenvolvedor/tela-carrousel.dart';
import 'package:pos_app/screens/000_carregamento/TelaDeCarregamentoPrincipal.dart';
import 'package:pos_app/screens/003_register/products/MyScreen.dart';
import 'package:pos_app/service/NotificationService.dart';
import 'package:cron/cron.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  //**************************************************************
  // var cron = new Cron();
  // cron.schedule(new Schedule.parse('*/3 * * * *'), () async {
  //   print('printa a cada novo cron chamado - momento -> ${DateTime.now()}');
  // });
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
