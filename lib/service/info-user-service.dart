import 'dart:convert';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../dtos/usuario-dto.dart';

Future<void> infoUserService() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? jsonString = prefs.getString(VariaveisGlobais.PREFERENCIASDOUSUARIO);
  if (jsonString != null) {
    Map<String, dynamic> jsonMap = jsonDecode(jsonString);
    VariaveisGlobais.usuarioDto = UsuarioDto.fromJson(jsonMap);
    print(VariaveisGlobais.usuarioDto.toJson());
  } else {
    VariaveisGlobais.usuarioDto = UsuarioDto(
      liberadoParaAcessar: false, tipoTitularOuColaborador: VariaveisGlobais.tipoTitularOuColaborador,
    );
    print(VariaveisGlobais.usuarioDto.toJson());
  }
}
