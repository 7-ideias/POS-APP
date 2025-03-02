import 'package:pos_app/dtos/objetos/obj-user.dart';
import 'package:pos_app/utilitarios/VariaveisGlobais.dart';

import 'objetos/obj-pessoa-dto.dart';

class UsuarioDto {
  String? id;
  String? idUsuario;
  int? statusCode;
  bool? liberadoParaAcessar;
  String? tipoDoAssinante;
  ObjUser? objUser;
  ObjPreferenciasDoAppRefleteParaTodosOsUsuarios? objPreferenciasDoAppRefleteParaTodosOsUsuarios;
  List<Null>? objLogsList;
  ObjPessoa? objPessoa;
  String? tipoTitularOuColaborador;


  UsuarioDto(
      {this.id,
        this.idUsuario,
        this.statusCode,
        this.liberadoParaAcessar,
        this.tipoDoAssinante,
        this.objUser,
        this.objPreferenciasDoAppRefleteParaTodosOsUsuarios,
        this.objLogsList,
        this.objPessoa,
        this.tipoTitularOuColaborador
      });

  UsuarioDto.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idUsuario = json['idUsuario'];
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
    objPessoa = json['objPessoa'] != null
        ? new ObjPessoa.fromJson(json['objPessoa'])
        : null;
    tipoTitularOuColaborador = VariaveisGlobais.tipoTitularOuColaborador;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['idUsuario'] = this.idUsuario;
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
    data['tipoTitularOuColaborador'] =this.tipoTitularOuColaborador;
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