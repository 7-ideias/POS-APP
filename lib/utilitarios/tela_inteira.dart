import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TelaInteira {
  Widget widgetDeLoadingPadraoDoApp() => Scaffold(
        body: SafeArea(
          child: Center(
            child: Lottie.asset('assets/loading.json'),
          ),
        ),
      );

  Widget sucesso() => SafeArea(
    child: Scaffold(
        body: Center(child: Lottie.asset('assets/success-mark.json'))),
  );

  Widget falha() => SafeArea(
    child: Scaffold(
        body: Center(child: Lottie.asset('assets/failed-button.json'))),
  );
}
