import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';

class AppController extends ChangeNotifier {
  static AppController instance = AppController();

  bool isDartTheme = true;
  var botaoTamanhoLetras = 25.0;

  //cores de ambiente
  MaterialAccentColor corAppBar = Colors.deepPurpleAccent;
  MaterialColor corTelaFundo = Colors.indigo;
  MaterialAccentColor corTelaAcima = Colors.indigoAccent;
  Color corLetras = Colors.white;
  MaterialColor corPrincipal = Colors.indigo;

  //cores botoes
  Color botaoConfirmar = Colors.indigo;
  Color botaoNegar = Colors.indigo;

  mudarCores(bool dark) {
    AppController.instance.isDartTheme = dark;
    if (corPrincipal == Colors.indigo) {
      corAppBar = Colors.deepPurpleAccent;
      corTelaFundo = Colors.indigo;
      corTelaAcima = Colors.indigoAccent;
      corLetras = Colors.white;
      botaoConfirmar = Colors.green;
      botaoNegar = Colors.red;
    } else if (corPrincipal == Colors.purple) {
      corAppBar = Colors.deepPurpleAccent;
      corTelaFundo = Colors.purple;
      corTelaAcima = Colors.purpleAccent;
      corLetras = Colors.white;
      botaoConfirmar = Colors.green;
      botaoNegar = Colors.red;
    } else if (corPrincipal == Colors.orange) {
      corAppBar = Colors.deepPurpleAccent;
      corTelaFundo = Colors.orange;
      corTelaAcima = Colors.orangeAccent;
      corLetras = Colors.white;
      botaoConfirmar = Colors.green;
      botaoNegar = Colors.red;
    }
    buildThemeData();
    notifyListeners();
  }


  ThemeData buildThemeData() {
    return ThemeData(
      brightness: isDartTheme == true ? Brightness.dark : Brightness.light,
    );
  }

}

