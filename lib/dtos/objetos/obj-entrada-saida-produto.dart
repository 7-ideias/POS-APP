class ObjEntradaSaidaProduto {
  String? id;
  String? idUserDoUsuario;
  String? tipo;
  DateTime? dataCadastro;
  double? quantidade;
  double? valorCusto;
  double? valorDaVenda;

  ObjEntradaSaidaProduto.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? json['id'] : null;
    idUserDoUsuario =
        json['idUserDoUsuario'] != null ? json['idUserDoUsuario'] : null;
    tipo = json['tipo'] != null ? json['tipo'] : null;
    dataCadastro = json['dataCadastro'] != null ? json['dataCadastro'] : null;
    quantidade = json['quantidade'] != null ? json['quantidade'] : null;
    valorCusto = json['valorCusto'] != null ? json['valorCusto'] : null;
    valorDaVenda = json['valorDaVenda'] != null ? json['valorDaVenda'] : null;
  }
}