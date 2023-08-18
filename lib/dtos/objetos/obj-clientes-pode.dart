class ObjClientesPode {
  bool? podeEditarCliente;

  ObjClientesPode.fromJson(Map<String, dynamic> json) {
    podeEditarCliente =
        json['podeEditarCliente'] != null ? json['podeEditarCliente'] : null;
  }
}
