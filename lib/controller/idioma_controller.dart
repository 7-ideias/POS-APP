import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pos_app/dtos/obj-idioma.dart';

import '../service/idioma-service.dart';

class Idioma extends ChangeNotifier {
  static Idioma instance = Idioma();

  mudarIdioma() {
    IdiomaService();
  }

  notifyListeners();
}
