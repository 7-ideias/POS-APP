import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pos_app/controller/app_controller.dart';

class TelaInteira {
  Widget widgetDeLoadingPadraoDoApp() => Scaffold(
        backgroundColor: AppController.instance.corTelaFundo,
        body: Center(
          child: Lottie.asset('assets/loading.json'),
        ),
      );

  Widget sucesso() => Scaffold(
      backgroundColor: AppController.instance.corTelaFundo,
      body: Center(child: Lottie.asset('assets/success-mark.json')));

  Widget falha() => Scaffold(
      backgroundColor: AppController.instance.corTelaFundo,
      body: Center(child: Lottie.asset('assets/failed-button.json')));
}
