import 'package:flutter/material.dart';
import 'package:pos_app/app/app.dart';
import 'package:pos_app/desenvolvedor/tela-carrousel.dart';
import 'package:pos_app/screens/000_carregamento/TelaDeCarregamentoPrincipal.dart';
import 'package:pos_app/screens/003_register/products/MyScreen.dart';
import 'package:pos_app/service/NotificationService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();

  //**************************************************************
  // runApp(const App()); //TODO PARA TESTAR O RELATORIO
  //**************************************************************
  runApp(TelaComCarousel());
  // runApp(TelaDeCarregamentoPrincipal());

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
