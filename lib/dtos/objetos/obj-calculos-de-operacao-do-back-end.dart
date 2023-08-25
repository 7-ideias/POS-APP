class ObjCalculosDeOperacaoDoBackEnd {
  late double vlTotal;
  late bool operacaoTotalmenteRecebida;

  ObjCalculosDeOperacaoDoBackEnd(
      {
        required this.vlTotal,
        required this.operacaoTotalmenteRecebida,
      });

  ObjCalculosDeOperacaoDoBackEnd.fromJson(Map<String, dynamic> json) {
    vlTotal = json['vlTotal'];
    operacaoTotalmenteRecebida = json['operacaoTotalmenteRecebida'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vlTotal'] = this.vlTotal;
    data['operacaoTotalmenteRecebida'] = this.operacaoTotalmenteRecebida;
    return data;
  }
}
