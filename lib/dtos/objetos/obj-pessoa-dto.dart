import 'obj-endereco.dart';
import 'obj-linha-de-credito.dart';

class ObjPessoa {
  String? atencao;
  String? nome;
  String? nomeDeGuerra;
  String? celular;
  String? senha;
  String? cpf;
  String? rg;
  String? dataDeNascimento;
  String? email;
  ObjEndereco? objEndereco;
  ObjetoLinhaDeCredito? objetoLinhaDeCredito;

  ObjPessoa(
      {this.atencao,
        this.nome,
        this.nomeDeGuerra,
        this.celular,
        this.senha,
        this.cpf,
        this.rg,
        this.dataDeNascimento,
        this.email,
        this.objEndereco,
        this.objetoLinhaDeCredito});

  ObjPessoa.fromJson(Map<String, dynamic> json) {
    atencao = json['atencao'];
    nome = json['nome'];
    nomeDeGuerra = json['nomeDeGuerra'];
    celular = json['celular'];
    senha = json['senha'];
    cpf = json['cpf'];
    rg = json['rg'];
    dataDeNascimento = json['dataDeNascimento'];
    email = json['email'];
    objEndereco = json['objEndereco'] != null
        ? new ObjEndereco.fromJson(json['objEndereco'])
        : null;
    objetoLinhaDeCredito = json['objetoLinhaDeCredito'] != null
        ? new ObjetoLinhaDeCredito.fromJson(json['objetoLinhaDeCredito']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['atencao'] = this.atencao;
    data['nome'] = this.nome;
    data['nomeDeGuerra'] = this.nomeDeGuerra;
    data['celular'] = this.celular;
    data['senha'] = this.senha;
    data['cpf'] = this.cpf;
    data['rg'] = this.rg;
    data['dataDeNascimento'] = this.dataDeNascimento;
    data['email'] = this.email;
    if (this.objEndereco != null) {
      data['objEndereco'] = this.objEndereco!.toJson();
    }
    if (this.objetoLinhaDeCredito != null) {
      data['objetoLinhaDeCredito'] = this.objetoLinhaDeCredito!.toJson();
    }
    return data;
  }
}
