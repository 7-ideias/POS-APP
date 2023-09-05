
import 'package:flutter/cupertino.dart';

import '../screens/jornada-tela.dart';

Future<dynamic> voltarEscolha(BuildContext context) {
  return Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      transitionDuration:
      Duration(milliseconds: 500),
      pageBuilder: (context, animation,
          secondaryAnimation) =>
          OutraTela(),
      transitionsBuilder: (context, animation,
          secondaryAnimation, child) {
        var begin = Offset(1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end)
            .chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    ),
  );
}
