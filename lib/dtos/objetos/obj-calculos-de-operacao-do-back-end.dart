class ObjCalculosDeOperacaoDoBackEnd {
  late double vlTotal;
  late bool operacaoTotalmenteRecebida;

  ObjCalculosDeOperacaoDoBackEnd(
      {
        required this.vlTotal,
        required this.operacaoTotalmenteRecebida,
      });

  ObjCalculosDeOperacaoDoBackEnd.fromJson(Map<String, dynamic> json) {
    // vlTotal = json['vlTotal'] != null ? json['vlTotal'] : null;
    // operacaoTotalmenteRecebida = json['operacaoTotalmenteRecebida'] != null
    //     ? json['operacaoTotalmenteRecebida']
    //     : null;
    vlTotal = json['vlTotal'];
    operacaoTotalmenteRecebida = json['operacaoTotalmenteRecebida'];
  }
}
