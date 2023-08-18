import 'package:pos_app/dtos/feitoObjetos/obj-pessoa-dto.dart';
import '../feitoObjetos/obj-empresa.dart';

class ObjUser {
  String? testeExpiraEm;
  bool? smsFoiValidado;
  ObjPessoa? objPessoa;
  ObjEmpresa? objEmpresa;

  ObjUser(
      {this.testeExpiraEm,
        this.smsFoiValidado,
        this.objPessoa,
        this.objEmpresa});

  ObjUser.fromJson(Map<String, dynamic> json) {
    testeExpiraEm = json['testeExpiraEm'];
    smsFoiValidado = json['smsFoiValidado'];
    objPessoa = json['objPessoa'] != null
        ? new ObjPessoa.fromJson(json['objPessoa'])
        : null;
    objEmpresa = json['objEmpresa'] != null
        ? new ObjEmpresa.fromJson(json['objEmpresa'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['testeExpiraEm'] = this.testeExpiraEm;
    data['smsFoiValidado'] = this.smsFoiValidado;
    if (this.objPessoa != null) {
      data['objPessoa'] = this.objPessoa!.toJson();
    }
    if (this.objEmpresa != null) {
      data['objEmpresa'] = this.objEmpresa!.toJson();
    }
    return data;
  }
}
