import 'package:pos_app/dtos/feitoObjetos/obj-user.dart';

class UsuarioDto {
  String? id;
  int? statusCode;
  bool? liberadoParaAcessar;
  String? tipoDoAssinante;
  ObjUser? objUser;
  ObjPreferenciasDoAppRefleteParaTodosOsUsuarios? objPreferenciasDoAppRefleteParaTodosOsUsuarios;
  List<Null>? objLogsList;

  UsuarioDto(
      {this.id,
        this.statusCode,
        this.liberadoParaAcessar,
        this.tipoDoAssinante,
        this.objUser,
        this.objPreferenciasDoAppRefleteParaTodosOsUsuarios,
        this.objLogsList});

  UsuarioDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    statusCode = json['statusCode'];
    liberadoParaAcessar = json['liberadoParaAcessar'];
    tipoDoAssinante = json['tipoDoAssinante'];
    objUser =
    json['objUser'] != null ? new ObjUser.fromJson(json['objUser']) : null;
    objPreferenciasDoAppRefleteParaTodosOsUsuarios =
    json['objPreferenciasDoAppRefleteParaTodosOsUsuarios'] != null
        ? new ObjPreferenciasDoAppRefleteParaTodosOsUsuarios.fromJson(
        json['objPreferenciasDoAppRefleteParaTodosOsUsuarios'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['statusCode'] = this.statusCode;
    data['liberadoParaAcessar'] = this.liberadoParaAcessar;
    data['tipoDoAssinante'] = this.tipoDoAssinante;
    if (this.objUser != null) {
      data['objUser'] = this.objUser!.toJson();
    }
    if (this.objPreferenciasDoAppRefleteParaTodosOsUsuarios != null) {
      data['objPreferenciasDoAppRefleteParaTodosOsUsuarios'] =
          this.objPreferenciasDoAppRefleteParaTodosOsUsuarios!.toJson();
    }
    return data;
  }
}

class ObjPreferenciasDoAppRefleteParaTodosOsUsuarios {
  String? idiomaPadraoDoAppParaRelatoriosEComprovantes;
  String? moedaPadraoDoAppParaRelatoriosEComprovantes;

  ObjPreferenciasDoAppRefleteParaTodosOsUsuarios(
      {this.idiomaPadraoDoAppParaRelatoriosEComprovantes,
        this.moedaPadraoDoAppParaRelatoriosEComprovantes});

  ObjPreferenciasDoAppRefleteParaTodosOsUsuarios.fromJson(
      Map<String, dynamic> json) {
    idiomaPadraoDoAppParaRelatoriosEComprovantes =
    json['idiomaPadraoDoAppParaRelatoriosEComprovantes'];
    moedaPadraoDoAppParaRelatoriosEComprovantes =
    json['moedaPadraoDoAppParaRelatoriosEComprovantes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idiomaPadraoDoAppParaRelatoriosEComprovantes'] =
        this.idiomaPadraoDoAppParaRelatoriosEComprovantes;
    data['moedaPadraoDoAppParaRelatoriosEComprovantes'] =
        this.moedaPadraoDoAppParaRelatoriosEComprovantes;
    return data;
  }
}