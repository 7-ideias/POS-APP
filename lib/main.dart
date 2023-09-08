import 'dart:async';

import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_app/screens/esqueceu-senha-tela.dart';
import 'package:pos_app/screens/idioma-tela.dart';
import 'package:pos_app/screens/login-tela.dart';
import 'package:pos_app/service/NotificationService.dart';
import 'package:pos_app/service/info-user-service.dart';
import 'package:pos_app/service/verifica-atualizacoes-para-cada-usuario.dart';
import 'package:pos_app/screens/home-tela.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';
import 'controller/app_controller.dart';

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

class TelaDeCarregamentoPrincipal extends StatefulWidget {
  @override
  State<TelaDeCarregamentoPrincipal> createState() =>
      _TelaDeCarregamentoPrincipalState();
}

class _TelaDeCarregamentoPrincipalState
    extends State<TelaDeCarregamentoPrincipal> {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: AppController.instance,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppController.instance.buildThemeData(),
            home: buildScaffold(),
            routes: {
            //   '/esqueceuSenha': (_) => EsqueceuTelaSenha(),
              '/login': (_) => LoginPage(),
              '/home': (_) => Home(),
            },
          );
        }
    );
  }

}
//
// class SplashPage extends StatefulWidget {
//   @override
//   _SplashPageState createState() => _SplashPageState();
// }
//
// class _SplashPageState extends State<SplashPage> {
//   @override
//   void initState() {
//     infoUserService();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return buildScaffold();
//   }
//
//   }

  Scaffold buildScaffold() {
    return Scaffold(
    body: Container(
      // decoration: const BoxDecoration(
      //   gradient: LinearGradient(
      //     colors: [Colors.redAccent, Colors.black],
      //     begin: Alignment.topCenter,
      //     end: Alignment.bottomCenter,
      //   ),
      // ),
      child: VariaveisGlobais.usuarioDto.liberadoParaAcessar == false
            ? const IdiomaTela()
            : const Home() ,

          //
          // VariaveisGlobais.usuarioDto.liberadoParaAcessar == false
          // ? LoginPage()
          // : Home(),
    ),
  );
}

