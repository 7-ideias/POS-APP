import 'dart:convert';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dtos/obj-idioma.dart';
import '../dtos/usuario-dto.dart';

Future<void> IdiomaService() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jsonString = prefs.getString(VariaveisGlobais.IDIOMADOAPP);
  if (jsonString != null) {
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    VariaveisGlobais.idiomaDto = IdiomaDto.fromJson(jsonMap);
  } else {

  }
}
