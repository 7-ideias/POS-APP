class ObjCalculosDeOperacaoDoBackEnd {
  double? vlTotal;

  bool? operacaoTotalmenteRecebida;

  ObjCalculosDeOperacaoDoBackEnd.fromJson(Map<String, dynamic> json) {
    vlTotal = json['vlTotal'] != null ? json['vlTotal'] : null;
    operacaoTotalmenteRecebida = json['operacaoTotalmenteRecebida'] != null
        ? json['operacaoTotalmenteRecebida']
        : null;
  }
}
