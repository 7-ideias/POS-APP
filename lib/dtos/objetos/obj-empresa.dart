import '../feitoObjetos/obj-endereco.dart';
import 'obj-colaborador.dart';

class ObjEmpresa {
  String? nomeDaEmpresa;
  String? nomeFantasia;
  String? cnpj;
  String? telefone;
  String? email;
  ObjEndereco? objEndereco;
  ObjColaborador? objColaborador;

  ObjEmpresa(
      {this.nomeDaEmpresa,
        this.nomeFantasia,
        this.cnpj,
        this.telefone,
        this.email,
        this.objEndereco,
        this.objColaborador
      });

  ObjEmpresa.fromJson(Map<String, dynamic> json) {
    nomeDaEmpresa = json['nomeDaEmpresa'];
    nomeFantasia = json['nomeFantasia'];
    cnpj = json['cnpj'];
    telefone = json['telefone'];
    email = json['email'];
    objEndereco = json['objEndereco'] != null
        ? new ObjEndereco.fromJson(json['objEndereco'])
        : null;
    objColaborador = json['objColaborador'] != null
        ? new ObjColaborador.fromJson(json['objColaborador'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nomeDaEmpresa'] = this.nomeDaEmpresa;
    data['nomeFantasia'] = this.nomeFantasia;
    data['cnpj'] = this.cnpj;
    data['telefone'] = this.telefone;
    data['email'] = this.email;
    if (this.objEndereco != null) {
      data['objEndereco'] = this.objEndereco!.toJson();
    }
    return data;
  }
}

