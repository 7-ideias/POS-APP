import 'obj-venda-e-servico.dart';

class ObjVendaEServicoList {
  List<ObjVendaEServico>? lista;

  ObjVendaEServicoList({
    this.lista,
  });

  factory ObjVendaEServicoList.fromJson(List<dynamic> jsonList) {
    List<ObjVendaEServico> list =
        jsonList.map((json) => ObjVendaEServico.fromJson(json)).toList();
    return ObjVendaEServicoList(
      lista: list,
    );
  }
}
