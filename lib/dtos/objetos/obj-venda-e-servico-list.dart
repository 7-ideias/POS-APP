import 'obj-venda-e-servico.dart';

class ObjVendaEServicoList {
  List<ObjVendaEServico>? vendaList;

  ObjVendaEServicoList(
      {
        required this.vendaList
      });

  ObjVendaEServicoList.fromJson(Map<String, dynamic> json) {
    if (json['vendaList'] != null) {
      vendaList = <ObjVendaEServico>[];
      json['vendaList'].forEach((v) {
        vendaList!.add(new ObjVendaEServico.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vendaList != null) {
      data['vendaList'] = this.vendaList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

