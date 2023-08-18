import '../feitoObjetos/obj-empresa.dart';
import '../feitoObjetos/obj-pessoa-dto.dart';

class ObjUser {
  DateTime? testeExpiraEm;
  bool? smsFoiValidado;
  ObjPessoa? objPessoa;
  ObjEmpresa? objEmpresa;

  ObjUser.fromJson(Map<String, dynamic> json) {
    testeExpiraEm =
        json['testeExpiraEm'] != null ? json['testeExpiraEm'] : null;
    smsFoiValidado =
        json['smsFoiValidado'] != null ? json['smsFoiValidado'] : null;
    objPessoa = json['objPessoa'] != null ? json['objPessoa'] : null;
    ObjEmpresa = json['ObjEmpresa'] != null ? json['ObjEmpresa'] : null;
  }
}